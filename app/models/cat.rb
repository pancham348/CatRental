class Cat < ActiveRecord::Base
  validates :birth_date, :color, :name, :sex, presence: true
  # validate :cat_born_before_today
  validate :color_must_be_possible_for_a_cat
  validate :cat_must_be_male_or_female
  
  has_many(
    :rental_requests,
    class_name: 'CatRentalRequest',
    foreign_key: :cat_id,
    primary_key: :id
  )
  
  def age
    @age = (birth_date - Date.current).to_i
  end
  
  def color_options
    ['brown', 'black', 'grey', 'white', 'orange', 'yellow']
  end
  
  def sex_options
    ["M", "F"]
  end
  
  private
  def color_must_be_possible_for_a_cat
    unless color_options.include?(color)
      errors[:color] << "cat can be one of these colors: #{color_options.join(", ")}"
    end
  end
  
  def cat_must_be_male_or_female
    unless sex_options.include?(sex)
      errors[:sex] << "please either choose 'M' for male or 'F' for female."
    end
  end
  
  # def cat_born_before_today
 #    unless birth_date != "" && Date.current - birth_date > 0
 #      errors[:birth_date] << "please choose a birthdate today or before"
 #    end
 #  end
end

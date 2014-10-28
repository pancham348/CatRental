class ChangeDateType < ActiveRecord::Migration
  def change
    change_column(:cats, :birth_date, :string)
  end
end

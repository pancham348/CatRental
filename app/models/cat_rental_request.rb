
class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date,  presence: true
  validate :status_actually_a_status
 validate :no_overlapping_requests
  
  after_initialize do
    self.status ||= 'PENDING'
  end
  
  belongs_to :cat
  
  def overlapping_approved_requests  
    
    query = <<-SQL
    SELECT a.*
    FROM cat_rental_requests AS a JOIN cat_rental_requests AS b ON a.id = b.id
    WHERE a.end_date >= b.start_date AND a.status = 'APPROVED'
    AND b.status = 'APPROVED' AND a.cat_id = b.cat_id
    
    SQL
    CatRentalRequest.connection.execute(query)
  end  
  
  private
  def status_actually_a_status
    statuses = ['PENDING', 'APPROVED', 'DENIED']
    statuses.include?(:status)
  end
  
  def no_overlapping_requests
    unless overlapping_approved_requests.num_tuples.zero?
      errors[:cat_rental_request] << "The request is not valid."
    end
  end
end

class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date,  presence: true
  validate :status_actually_a_status
  validate :no_overlapping_requests
  
  after_initialize do
    self.status ||= 'PENDING'
  end
  
  belongs_to :cat,  dependent: :destroy
  
  def overlapping_approved_requests  
  CatRentalRequest
    .select("cat_rental_requests.*")
    .joins("cat_rental_requests AS a")
    .joins("cat_rental_requests AS b")
    .where("a.end_date >= b.start_date AND a.status = 'APPROVED'
    AND b.status = 'APPROVED' AND a.id != b.id")
  end  
  
  private
  def status_actually_a_status
    statuses = ['PENDING', 'APPROVED', 'DENIED']
    statuses.inclue?(:status)
  end
  
  def no_overlapping_requests
    unless overlapping_approved_requests.empty?
      errors[:cat_rental_request] << "The request is not valid."
    end
  end
end

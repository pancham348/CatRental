class CatRentalRequestsController < ApplicationController
  
  def new
    @cat = Cat.find(params[:cat_id])
    @rental_request = @cat.rental_requests.new
    render :new
  end
  
  def create
    @rental_request = CatRentalRequest.new(cat_rental_params)
    @cat = @rental_request.cat
    if @rental_request.save
      redirect_to cat_url(@cat.id)
    else
      render :new
    end
  end
  
  def show
    @rental_request = CatRentalRequest.find(params[:id])
    render :show
  end
  
  private
  
  def cat_rental_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end
  
end
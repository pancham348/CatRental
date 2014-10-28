class CatRentalRequestsController < ApplicationController
  
  def new
    @cat_rental = CatRentalRequest.new
    @cat = Cat.find(params[:cat_id])
    render :new
  end
  
  def create
    @cat_rental = CatRentalRequest.new(cat_rental_params)
    if @cat_rental.save
      redirect_to_cat_rental_reuqest_url
    else
      render :new
    end
  end
  
  def show
    @cat_rental = CatRentalRequest.find(params[:id])
    render :show
  end
  
  private
  
  def cat_rental_params
    params.require(:cat_rental_requests).permit(:cat_id, :start_date, :end_date)
  end
  
end
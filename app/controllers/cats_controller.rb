class CatsController < ApplicationController
  
  def index
    @cats = Cat.all
    render :index
  end
  
  def show
    @cat = Cat.find(params[:id])
    render :show
  end
  
  def new
    render :new
  end
  
  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to cat_url
    else
      render :new
    end
  end
  
  private
  
  def cat_params
    params.require(:cat)
  end
end

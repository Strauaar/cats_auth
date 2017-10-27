class CatsController < ApplicationController
  before_action :check_user, only:[:edit, :update]
  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create

    @cat = Cat.new(cat_params)
    @cat.owner = current_user
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end

  def edit
    # @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    # @cat = Cat.find(params[:id])
    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end

  def check_user
    @cat = Cat.find(params[:id])
    if current_user.nil? || !current_user.cats.include?(@cat)
      flash[:errors] = ["This is not your cat. Stay away, malicious being"]
      redirect_to cat_url(@cat)
    end
  end

  private

  def cat_params
    params.require(:cat).permit(:age, :birth_date, :color, :description, :name, :sex)
  end
end

class CatRentalRequestsController < ApplicationController
  def approve
    crr = CatRentalRequest.find(params[:id])
    cat = crr.cat
    if cat.owner == current_user
      current_cat_rental_request.approve!
    else
      flash[:rental_errors] = ["You cannot approve this request"]
    end
    redirect_to cat_url(current_cat)
  end

  def create
    @rental_request = CatRentalRequest.new(cat_rental_request_params)
    @rental_request.requester = current_user
    if @rental_request.save
      redirect_to cat_url(@rental_request.cat)
    else
      flash.now[:errors] = @rental_request.errors.full_messages
      render :new
    end
  end

  def deny
    crr = CatRentalRequest.find(params[:id])
    cat = crr.cat
    if current_user == cat.owner
      current_cat_rental_request.deny!
    else
      flash[:rental_errors] = ["You cannot deny this request"]
    end
    redirect_to cat_url(current_cat)
  end

  def new
    @rental_request = CatRentalRequest.new
  end

  private

  def current_cat_rental_request
    @rental_request ||=
      CatRentalRequest.includes(:cat).find(params[:id])
  end

  def current_cat
    current_cat_rental_request.cat
  end

  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:cat_id, :end_date, :start_date, :status)
  end
end

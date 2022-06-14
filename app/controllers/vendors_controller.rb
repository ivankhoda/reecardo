class VendorsController < ApplicationController
  protect_from_forgery with: :null_session

  def new
    @vendor = Vendor.new
  end

  def index
    vendors = Vendor.find_each
    render json: { vendors: }
  end

  def show
    vendor = Vendor.find_by(id: params[:id])
    render json: { vendor: }
  end

  def create
    @vendor = Vendor.new(vendor_params)
    if @vendor.save
      render json: { message: 'Vendor succesfully created' }
    else
      render json: { error: @vendor.errors.messages }
    end
  end

  def update
    vendor = Vendor.find_by(id: params[:id])
    if !vendor.nil?
      vendor.update(vendor_params)
      render json: { vendor: }
    else
      render json: { error: 'Vendor not found' }, status: 422
    end
  end

  def destroy
    vendor = Vendor.find_by(id: params[:id])
    if !vendor.nil?
      vendor.task_ranges.destroy
      vendor.destroy
      render json: { message: 'Vendor was removed' }
    else
      render json: { error: 'Vendor not found' }, status: 422
    end
  end

  private

  def vendor_params
    params.require(:vendor).permit(:name, :alias, :codetype_id)
  end
end

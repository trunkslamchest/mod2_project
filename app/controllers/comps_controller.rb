class CompsController < ApplicationController

  def show
    @comp = Comp.find(params[:id])
    @property = @comp.property
  end

  private

  def report_params
    params.require(:comp).permit(:property_id, :price, :zp_id, )
  end

end

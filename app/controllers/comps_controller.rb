class CompsController < ApplicationController

    def show
        @comp = Comp.find(params[:id])
        @property = @comp.property
    end

    #there doesn't need to be a new or create page because comps are generated when a search is executed

    private

    def report_params
        params.require(:comp).permit(:property_id, :price, :zp_id, )
    end
end

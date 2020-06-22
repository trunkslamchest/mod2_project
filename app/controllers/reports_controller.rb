class ReportsController < ApplicationController

    def show
        @report = Report.find(params[:id])
        @property = @report.property
        @comps = @property.comps
        @favorite = Favorite.new
    end

    def index
        @reports = @current_user.reports
    end

    def create
      @report = Report.create(report_params)
        if @report.save
        redirect_to @report
        end
    end

    private

    def report_params
        params.require(:report).permit(:user_id, :property_id)
    end

end

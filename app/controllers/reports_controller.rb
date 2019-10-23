class ReportsController < ApplicationController

<<<<<<< HEAD
=======

>>>>>>> b76799d16b7b6759d68079de3c9d46a81ba1282d
    def show
        @report = Report.find(params[:id])
        @property = @report.property
        @comps = @property.comps

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

class ReportsController < ApplicationController

  def index
    @reports = Report.all
  end
  
end

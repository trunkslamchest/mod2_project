class PropertiesController < ApplicationController

	def index
		all_properties
	end
	
	def show
		find_property
	end

private
	
	def find_property
		@property = Property.find(params[:id])
	end

	def all_properties
		@properties = Property.all
	end

end

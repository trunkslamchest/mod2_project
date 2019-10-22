class PropertiesController < ApplicationController
	# before_action :start_zester

def index
	all_properties
end

private

	def all_properties
		@properties = Property.all
	end

end

class PropertiesController < ApplicationController

	# def index
	# 	my_properties
	# end

	def show
		@property = Property.find(params[:id])
		@comps = @property.comps
		@report = Report.new
		@favorite = Favorite.new
	end

	def new
		@property = Property.new
		@states = all_states
	end

	def create
		@property = Property.create(property_params)
		if @property.valid?
			redirect_to @property
		else
			  flash[:errors] = @property.errors.full_messages
			  redirect_to new_property_path
		end
	end


private

	 def property_params
		params.require(:property).permit(:street_address, :city, :state, :zp_id, :user_id)
	 end

	def my_properties
		@properties = @current_user.properties
	end

	def all_states
		[ "AK",
		"AL",
		"AR",
		"AS",
		"AZ",
		"CA",
		"CO",
		"CT",
		"DC",
		"DE",
		"FL",
		"GA",
		"GU",
		"HI",
		"IA",
		"ID",
		"IL",
		"IN",
		"KS",
		"KY",
		"LA",
		"MA",
		"MD",
		"ME",
		"MI",
		"MN",
		"MO",
		"MS",
		"MT",
		"NC",
		"ND",
		"NE",
		"NH",
		"NJ",
		"NM",
		"NV",
		"NY",
		"OH",
		"OK",
		"OR",
		"PA",
		"PR",
		"RI",
		"SC",
		"SD",
		"TN",
		"TX",
		"UT",
		"VA",
		"VI",
		"VT",
		"WA",
		"WI",
		"WV",
		"WY"]
	end

end

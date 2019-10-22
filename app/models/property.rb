class Property < ApplicationRecord
	belongs_to :user
	after_initialize :start_zester

	# attr_reader :street_address, :city, :state, :zester, :zp_id

	# def initialize(street_address, city, state)
	# 	@street_address = street_address
	# 	@city = city
	# 	@state = state
	# 	@zester = Zester::Client.new('insert key')
	# end

	def start_zester
		@zester = Zester::Client.new('')
		# get_zp_id
		# get_deep_search_results
	end

	def get_deep_search_results
		# @zester = Zester::Client.new('insert key')
		@zester.property.deep_search_results('address' => "#{self.street_address}", 'citystatezip' => "#{self.city}, #{self.state}")
	end

	def get_zp_id
	   zresponse = self.get_deep_search_results
	   self.zp_id = zresponse.body["response"]["results"]["result"]["zpid"]
	end

	def get_deep_comps
	 @zester.property.deep_comps('zpid' => self.get_zp_id )
	end

	def collect_comps
	   zresponse = self.get_deep_comps
	   zresponse.body["response"]["properties"]["comparables"]["comp"]
	end

	def find_details_by_zp_id
	   my_zp_id = self.zp_id
	   @zester.property.updated_property_details('zpid' => my_zp_id )
	end

	def get_images
	 zresponse = find_details_by_zp_id
	 zresponse.body["response"]["images"]["image"]["url"]
	end

	# binding.pry
	# 0

end
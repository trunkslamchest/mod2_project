class Property < ApplicationRecord
	belongs_to :user
	has_many :comps, dependent: :destroy
	before_create :get_zp_id
	after_create :build_comps
	after_initialize :start_zester

	def zester
		#this is a reader method for @zester, which is NOT stored in the DB
		#from here, we can call Zester methods off this object
     @zester
	end

	def start_zester
		#sets instance variable zester and tells the property what its zp_id is
		@zester = Zester::Client.new('X1-ZWz1hfcq3wk5jf_4wzn5')
	end

	def get_deep_search_results
		@zester.property.deep_search_results('address' => "#{self.street_address}", 'citystatezip' => "#{self.city}, #{self.state}")
	end

	def zipcode
	 zresponse = get_deep_search_results
	 zresponse.body["response"]["results"]["result"]["address"]["zipcode"]
	end

	def main_image
		get_images.first
	end

	def get_zp_id
	   zresponse = self.get_deep_search_results
	   if zresponse.body["response"].nil?
		return zresponse.body["message"]["text"]
		self.destroy
	   else
		if zresponse.body["response"]["results"]["result"].class == Array
			self.zp_id = zresponse.body["response"]["results"]["result"][0]["zpid"]
		else
			self.zp_id = zresponse.body["response"]["results"]["result"]["zpid"]
		end

	   end
	end

	def price
	  zestimate = self.get_deep_search_results.body["response"]["results"]["result"]["zestimate"]["amount"]["_content_"]
		if zestimate.nil?
			#if both price and zestimate are unavailable, generate a random price
			#fake data, but oh well
			rand(300000..900000)
		else
			zestimate.to_i
	  end
	end

	def get_deep_comps
		#HELPER METHOD
	 @zester.property.deep_comps('zpid' => self.get_zp_id )
	end


	def collect_comps
		#gives us an array of hashes with comp data
		#HELPER METHOD
	   zresponse = self.get_deep_comps
	   zresponse.body["response"]["properties"]["comparables"]["comp"]
	end

	def find_details_by_zp_id(my_zp_id = self.zp_id)
	   @zester.property.updated_property_details('zpid' => my_zp_id )
	end

	def get_images
	 zresponse = find_details_by_zp_id
	 if zresponse.body["response"] == nil
		 return ["https://i.pinimg.com/originals/48/bc/d6/48bcd68d718226b7febeb4407548953d.png"]
	 else
		zresponse.body["response"]["images"]["image"]["url"]

	 end
	end

	def bedrooms
		self.get_deep_search_results.body["response"]["results"]["result"]["bedrooms"]
	end

	def bathrooms
		self.get_deep_search_results.body["response"]["results"]["result"]["bathrooms"]
	end

	def square_footage
     self.get_deep_search_results.body["response"]["results"]["result"]["finished_sq_ft"]
	end

	def build_comps
		my_comps = self.collect_comps

		my_comps.each { |comp|
		Comp.create(
			property_id: self.id,
			zp_id: comp["zpid"],
			beds: comp["bedrooms"],
			bath: comp["bathrooms"],
			price: comp["last_sold_price"]["_content_"].to_d
		)
	}

	end

end
class Comp < ApplicationRecord
	belongs_to :property
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

	def get_deep_comps
		#HELPER METHOD
	 @zester.property.deep_comps('zpid' => self.zp_id )
	end

	def find_details_by_zp_id(my_zp_id = self.zp_id)
	  @zester.property.updated_property_details('zpid' => my_zp_id )
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

	def city
		self.get_deep_comps.body["response"]["properties"]["principal"]["address"]["city"]
	end 

	def state
		self.get_deep_comps.body["response"]["properties"]["principal"]["address"]["state"]
	end 

	def street_address
     self.get_deep_comps.body["response"]["properties"]["principal"]["address"]["street"]
	end

	def zipcode
		self.get_deep_comps.body["response"]["properties"]["principal"]["address"]["zipcode"]
	end

	def main_image
		get_images.first
	end 

	def get_images
		zresponse = find_details_by_zp_id
		if zresponse.body["response"] == nil
			return ["https://i.pinimg.com/originals/48/bc/d6/48bcd68d718226b7febeb4407548953d.png"]
		else
		   zresponse.body["response"]["images"]["image"]["url"]
			
		end
	end

end

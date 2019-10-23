class Property < ApplicationRecord
	belongs_to :user
	has_many :comps, dependent: :destroy
	before_create :get_zp_id
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



end
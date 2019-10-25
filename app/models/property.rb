class Property < ApplicationRecord
	belongs_to :user
	has_many :comps, dependent: :destroy
	before_create :get_zp_id
	after_create :build_comps
	after_initialize :start_zester

	validates :street_address, :city, :state, :user_id, presence: true

	def zester
		#this is a reader method for @zester, which is NOT stored in the DB
		#from here, we can call Zester methods off this object
     @zester
	end

	def start_zester
		#sets instance variable zester and tells the property what its zp_id is
		@zester = Zester::Client.new(ENV['SECRET_ZILLOW'])
	end

	def get_deep_search_results
		@zester.property.deep_search_results('address' => "#{self.street_address}", 'citystatezip' => "#{self.city}, #{self.state}")
	end

	def zipcode
	 begin 
	  zresponse = get_deep_search_results
	  zresponse.body["response"]["results"]["result"]["address"]["zipcode"]
	 rescue 
      begin
		zresponse.body["response"]["results"]["result"][0]["address"]["zipcode"]
	  rescue 
		  "Unknown zipcode"
	  end
	 end 
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
	 begin
	   zresponse = self.get_deep_comps
	   zresponse.body["response"]["properties"]["comparables"]["comp"]
	 rescue 
      @comp_error = zresponse.body["message"].text
	 end 
	end

	def find_details_by_zp_id(my_zp_id = self.zp_id)
	   @zester.property.updated_property_details('zpid' => my_zp_id )
	end

	def get_images
	 zresponse = find_details_by_zp_id
	 if zresponse.body["response"] == nil && self.google_connect["status"] == "OK"
		 
	 [self.get_google_img]
	 
	 elsif self.google_connect["status"] != "OK"

	 minecraft_houses = ["https://cdn1-www.gamerevolution.com/assets/uploads/2019/04/Modest-Living-House-640x360.png",
	 "https://res.cloudinary.com/lmn/image/upload/e_sharpen:100/f_auto,fl_lossy,q_auto/v1/gameskinnyc/m/i/n/minecraft-suburban-house-youtube-20679.png",
	 "https://www.minecraft-schematics.com/schematics/pictures/13786/list-picture-13786.png?time=1571590236",
	 "https://images-na.ssl-images-amazon.com/images/S/sgp-catalog-images/region_US/hdp09-Y3ZVHCAWA8F-Full-Image_GalleryBackground-en-US-1520541360917._SX1080_.jpg"]
	 
	 [minecraft_houses.sample]

	 else
		zresponse.body["response"]["images"]["image"]["url"]
	 end
	end

	def google_connect
		api_url = "https://maps.googleapis.com/maps/api/streetview/metadata?location=#{self.street_address} #{self.city} #{self.state}&key=#{ENV['SECRET_GOOGLE']}"
		response_string = RestClient.get(api_url)
		JSON.parse(response_string)
	end 

	def get_google_img
		response_hash = self.google_connect
		pano = response_hash["pano_id"]
		"https://maps.googleapis.com/maps/api/streetview?size=600x300&pano=#{pano}&key=#{ENV['SECRET_GOOGLE']}"
	end 
  
	def bedrooms 
	  begin
		self.get_deep_search_results.body["response"]["results"]["result"]["bedrooms"]
	  rescue 
	   begin 
		self.get_deep_search_results.body["response"]["results"]["result"][0]["bedrooms"]
	   rescue 
		"Unknown"
	   end 
	  end 
	end 

	def bathrooms 
		begin
			self.get_deep_search_results.body["response"]["results"]["result"]["bathrooms"]
		  rescue 
		   begin 
			self.get_deep_search_results.body["response"]["results"]["result"][0]["bathrooms"]
		   rescue 
			"Unknown"
		   end 
		  end 
	end 

	def square_footage
	 begin
		self.get_deep_search_results.body["response"]["results"]["result"]["finished_sq_ft"]
	  rescue 
	   begin 
		self.get_deep_search_results.body["response"]["results"]["result"][0]["finished_sq_ft"]
	   rescue 
		"Unknown"
	   end 
	  end 
	end

	def build_comps
	  begin
		my_comps = self.collect_comps

		my_comps.each { |comp|
		Comp.create(
			property_id: self.id,
			zp_id: comp["zpid"],
			beds: comp["bedrooms"],
			bath: comp["bathrooms"],
			price: 
			if comp["last_sold_price"] == nil
			 comp["zestimate"]
			elsif comp["zestimate"] == nil && comp["last_sold_price"] == nil
				rand(300000...900000)
			else
			 comp["last_sold_price"]["_content_"].to_d
			end  
		)
	  }
     rescue 
      @comp_error
	 end 
	end 

end
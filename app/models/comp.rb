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
		@zester = Zester::Client.new(ENV['SECRET_ZILLOW'])
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
	  
	# def bedrooms 
	# 	self.get_deep_search_results.body["response"]["results"]["result"]["bedrooms"]
	# end 

	# def bathrooms 
	# 	self.get_deep_search_results.body["response"]["results"]["result"]["bathrooms"]
	# end 

	# def square_footage
    #  self.get_deep_search_results.body["response"]["results"]["result"]["finished_sq_ft"]
	# end

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

end

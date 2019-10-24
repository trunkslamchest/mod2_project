include ActionView::Helpers::NumberHelper

class Report < ApplicationRecord

	belongs_to :user
	belongs_to :property
	before_create :set_values
	# after_find :build_comp_array

	# def build_comp_array
	#  @comp_array = self.property.comps
	# end 

	def set_values
		self.avg_price = set_avg_price
		self.avg_bath = set_avg_bath
		self.avg_bed = set_avg_bed
		self.avg_size = set_avg_size
	end 

	def all_comp_sq_ft
	  begin 
		a = self.property.comps.map { |comp| comp.square_footage.to_f }
		a.map {|x| x == 0.0 ? rand(1500...3000) : x}
	  rescue
		[rand(1500...3000), rand(1500...3000), rand(1500...3000), rand(1500...3000), rand(1500...3000)]
	 end 
	end 

	def all_comp_price
	  begin
		a = self.property.comps.map { |comp| comp.price.to_f }
		a.map {|x| x == 0.0 ? rand(150000..900000) : x}
	  rescue 
		[rand(150000..900000), rand(150000..900000), rand(150000..900000), rand(150000..900000), rand(150000..900000)]
	  end 
	end 

	def all_comp_bedrooms
	  begin
		a = self.property.comps.map { |comp| comp.bedrooms.to_f }
		a.map {|x| x == 0.0 ? rand(2..5) : x}
	  rescue 
		[rand(2..5), rand(2..5), rand(2..5), rand(2..5), rand(2..5)]
	  end 
	end 

	def all_comp_bathrooms
	 begin
		a = self.property.comps.map { |comp| comp.bathrooms.to_f }
		a.map {|x| x == 0.0 ? rand(2..5) : x}
	 rescue 
		[rand(2..5), rand(2..5), rand(2..5), rand(2..5), rand(2..5)]
	 end 
	end 

	def set_avg_size
	 begin 
		added_up = all_comp_sq_ft.reduce(:+)
		leng = all_comp_sq_ft.length
		added_up / leng
	 rescue 
		return "UNKOWN"
	 end 
	end 

	def size_comparison
		begin
		numerator = self.property.square_footage.to_i - self.avg_size
		denom = self.property.square_footage.to_i
		numerator / denom
		rescue
			return "UNKNOWN"
		end
	end 

	def smaller_or_larger
	 begin
		if self.size_comparison.negative?
			return "smaller"
		else 
			return "larger"
		end
	 rescue 
		return "UNKNOWN"
	 end
	end 

	def set_avg_price
	 begin
		added_up = all_comp_price.reduce(:+)
		leng = all_comp_price.length
	  added_up / leng
	 rescue 
		return "UNKNOWN"
	 end 
	end 

	def price_comparison
	  begin
		numerator = self.property.price.to_i - self.avg_price
		denom = self.property.price.to_i
		numerator / denom
	  rescue 
		return "UNKNOWN"
	  end
	end 

	def cheaper_or_more_expensive
	 begin
		if self.price_comparison.negative?
			return "cheaper"
		else 
			return "more expensive"
		end
	 rescue 
		return "UNKNOWN"
	 end 
	end 

	def set_avg_bed	
	 begin	
		added_up = all_comp_bedrooms.reduce(:+)
		leng = all_comp_bedrooms.length
	  added_up / leng
	 rescue 
		return "UNKNOWN"
	 end 
	end

	def more_or_less_beds
	 begin
		if self.avg_bed > self.property.bedrooms.to_f
			return "less"
		else 
			return "more"
		end 
	 rescue 
		return "UNKNOWN"
	 end
	end 

	def set_avg_bath
	 begin 
		added_up = all_comp_bathrooms.reduce(:+)
		leng = all_comp_bathrooms.length
	  added_up / leng
	 rescue 
		return "UNKNOWN"
	 end
	end 

	def more_or_less_baths
	 begin
		if self.avg_bath > self.property.bathrooms.to_f
			return "less"
		else 
			return "more"
		end 
	end 
	 rescue 
		return "UNKNOWN"
	 end
end

include ActionView::Helpers::NumberHelper

class Report < ApplicationRecord

	belongs_to :user
	belongs_to :property
	before_create :set_values
	after_find :comp_array

	def comp_array
	 @comp_array = self.property.comps
	end 

	def set_values
		self.avg_price = set_avg_price
		self.avg_bath = set_avg_bath
		self.avg_bed = set_avg_bed
		self.avg_size = set_avg_size
	end 

	def all_comp_sq_ft
		a = @comp_array.map { |comp| comp.square_footage.to_f }
		a.reject { |size| size == 0.0 }
	end 

	def all_comp_price
		a = @comp_array.map { |comp| comp.price.to_f }
		a.reject { |price| price == 0.0 }
	end 

	def all_comp_bedrooms
		a = @comp_array.map { |comp| comp.bedrooms.to_f }
		a.reject { |num_beds| num_beds == 0.0 }
	end 

	def all_comp_bathrooms
		a = @comp_array.map { |comp| comp.bathrooms.to_f }
		a.reject { |num_baths| num_baths == 0.0 }
	end 

	def set_avg_size
		added_up = all_comp_sq_ft.reduce(:+)
		leng = all_comp_sq_ft.length
		added_up / leng
	end 

	def size_comparison
		numerator = self.property.square_footage.to_i - self.avg_size
		denom = self.property.square_footage.to_i
		numerator / denom
	end 

	def smaller_or_larger
		if self.size_comparison.negative?
			return "smaller"
		else 
			return "larger"
		end
	end 

	def set_avg_price
		added_up = all_comp_price.reduce(:+)
		leng = all_comp_price.length
      added_up / leng
	end 

	def price_comparison
		numerator = self.property.price.to_i - self.avg_price
		denom = self.property.price.to_i
		numerator / denom
	end 

	def cheaper_or_more_expensive
		if self.price_comparison.negative?
			return "cheaper"
		else 
			return "more expensive"
		end
	end 

	def set_avg_bed		
		added_up = all_comp_bedrooms.reduce(:+)
		leng = all_comp_bedrooms.length
      added_up / leng
	end

	def more_or_less_beds
		if self.avg_bed > self.property.bedrooms.to_f
			return "less"
		else 
			return "more"
		end 
	end 

	def set_avg_bath
		added_up = all_comp_bathrooms.reduce(:+)
		leng = all_comp_bathrooms.length
      added_up / leng
	end 

	def more_or_less_baths
		if self.avg_bath > self.property.bathrooms.to_f
			return "less"
		else 
			return "more"
		end 
	end 

end

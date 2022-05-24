class Car
	attr_reader :reg_no, :color

	def intialize(reg_no:, color:, price:)
		@reg_no = reg_no
		@color = color
		@price = price
	end
end
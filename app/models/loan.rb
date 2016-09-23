class Loan < ActiveRecord::Base
	belongs_to :employee

	#validates :capital_requisition, :numericality => { :less_than_or_equal_to => :capital_requisition }
    #validates :capital_requisition, :numericality => { :less_than_or_equal_to => :max_credit }
	def self.get_period
		(Time.now.end_of_month.day - Time.now.day)
	end
	has_many :pagos
end

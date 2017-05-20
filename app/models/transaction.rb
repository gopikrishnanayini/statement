class Transaction < ActiveRecord::Base 

    scope :this_month, -> { where(created_at: Time.now.beginning_of_month..Time.now.end_of_month) } 
	
	def self.income_for_user
	  Transaction.where(:transactionable_type => "income")
	end 
	def self.expense_for_user
	  Transaction.where(:transactionable_type => "expense")
	end 
end

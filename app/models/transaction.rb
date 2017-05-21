class Transaction < ActiveRecord::Base 

    # scope :this_month, -> { where(created_at: Time.now.beginning_of_month..Time.now.end_of_month) } 
	
	def self.income_for_user
	  Transaction.where(:transactionable_type => "income")
	end 

	def self.expense_for_user
	  Transaction.where(:transactionable_type => "expense")
	end 

	def self.report_search(start_date, end_date)
	  starting_date = Date.strptime(start_date, "%m/%d/%Y")
      ending_date = Date.strptime(end_date, "%m/%d/%Y")
	  Transaction.where("DATE(enter_date) BETWEEN ? AND ?", starting_date, ending_date)
	end
end

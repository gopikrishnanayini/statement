class Transaction < ActiveRecord::Base 
    validates :type_of_income_and_expense, :amount,:enter_date, presence: true
    validates_numericality_of :amount
    # scope :this_month, -> { where(created_at: Time.now.beginning_of_month..Time.now.end_of_month) } 
	
	def self.income_for_user
	  Transaction.where(:transactionable_type => "income")
	end 

	def self.expense_for_user
	  Transaction.where(:transactionable_type => "expense")
	end 

	def self.report_search_new(start_date, end_date)
     if !start_date.nil? && !end_date.nil?
	  starting_date = Date.strptime(start_date, "%m/%d/%Y")
      ending_date = Date.strptime(end_date, "%m/%d/%Y")
	  Transaction.where("DATE(enter_date) BETWEEN ? AND ?", starting_date, ending_date)
	  end
	end

	def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |product|
        csv << product.attributes.values_at(*column_names)
      end
    end
  end

end

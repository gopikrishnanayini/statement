class AddTypeOfIncomeAndExpenseToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :type_of_income_and_expense, :string
  end
end

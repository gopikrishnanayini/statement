class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :amount
      t.date :enter_date
      t.belongs_to :transactionable, polymorphic: true

      t.timestamps null: false
    end
    add_index :transactions, [:transactionable_id, :transactionable_type], :name => 'my_index'
  end
end

class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.string :name
      t.string :merchant
      t.decimal :amount
      t.date :transaction_date
      t.string :category

      # Add foreign key references to the merchants and categories tables
      t.references :merchant, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end

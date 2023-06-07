class DropTransactionsTable < ActiveRecord::Migration[6.1]
  def up
    drop_table :transactions
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

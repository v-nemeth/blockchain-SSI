class CreateTransaction < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.string :chain_id
      t.string :from_address, null: false
      t.string :to_address, null: false

      t.string :tx_hash, index: true
      t.string :block_number

      t.string :data
      t.string :value\

      t.string :gas_limit
      t.string :gas_price
      t.string :max_fee_per_gas
      t.string :max_priority_fee_per_gas
      t.string :gas_used

      t.integer :status

      t.references :document, foreign_key: true, null: true
      t.references :corporation

      t.timestamps
    end
  end
end

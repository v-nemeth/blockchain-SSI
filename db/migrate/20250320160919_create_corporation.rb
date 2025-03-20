class CreateCorporation < ActiveRecord::Migration[8.0]
  def change
    create_table :corporations do |t|
      t.string :title
      t.string :private_key, limit: 4096  # Increased size for keys
      t.string :public_key, limit: 4096
      t.timestamps
    end
  end
end

class CreateDocuments < ActiveRecord::Migration[8.0]
  def change
    create_table :documents do |t|
      t.boolean :signed

      t.timestamps
    end
  end
end

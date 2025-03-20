class AddSha256ToDocuments < ActiveRecord::Migration[8.0]
  def change
    add_column :documents, :sha256, :string
  end
end

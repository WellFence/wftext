class AddDocumentToPerson < ActiveRecord::Migration[5.0]
  def change
    add_column :people, :document, :string
  end
end

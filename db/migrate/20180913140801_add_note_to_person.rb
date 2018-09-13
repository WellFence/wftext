class AddNoteToPerson < ActiveRecord::Migration[5.0]
  def change
    add_column :people, :note, :string, :limit => 250
  end
end

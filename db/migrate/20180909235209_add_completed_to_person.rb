class AddCompletedToPerson < ActiveRecord::Migration[5.0]
  def change
    add_column :people, :completed, :boolean
  end
end

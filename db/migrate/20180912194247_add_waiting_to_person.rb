class AddWaitingToPerson < ActiveRecord::Migration[5.0]
  def change
    add_column :people, :waiting, :boolean
  end
end

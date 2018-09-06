class CreatePeople < ActiveRecord::Migration[5.0]
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :company
      t.string :position
      t.string :email
      t.string :phone
      t.string :h2s
      t.boolean :has_card
      t.string :card_number
      t.string :rig

      t.timestamps
    end
  end
end

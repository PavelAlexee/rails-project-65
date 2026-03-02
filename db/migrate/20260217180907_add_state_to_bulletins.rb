class AddStateToBulletins < ActiveRecord::Migration[8.1]
  def change
    add_column :bulletins, :state, :string, null: false, default: 'draft'
    add_index :bulletins, :state
  end
end

class AddActiveToList < ActiveRecord::Migration[7.1]
  def change
    add_column :lists, :active, :boolean, default: false
    add_index :lists, [:deck_id, :active], unique: true, where: '(active IS TRUE)'
  end
end

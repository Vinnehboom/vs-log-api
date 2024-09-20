class AddFavoriteToMatch < ActiveRecord::Migration[7.1]
  def change
    add_column :matches, :favorite, :boolean, default: false
  end
end

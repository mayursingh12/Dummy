class AddColumsToBeer < ActiveRecord::Migration
  def change
    add_column :beers, :price, :float, default: 0.0
    add_column :beers, :description, :text
    add_column :beers, :pair_with, :text
  end
end

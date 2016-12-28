class AddBeerCategoryIdToBeer < ActiveRecord::Migration
  def change
    add_column :beers, :beer_category_id, :integer
  end
end

class AddSlugToBeer < ActiveRecord::Migration
  def change
    add_column :beers, :slug, :string
  end
end

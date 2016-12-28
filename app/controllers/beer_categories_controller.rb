class BeerCategoriesController < ApplicationController

  before_action :set_beer_category, only: [:edit, :update, :destroy]

  def index
    @beer_categories = BeerCategory.all
  end

  def new
    @beer_category = BeerCategory.friendly.new
  end

  def create
    @beer_category = BeerCategory.friendly.new(beer_category_params)
    if @beer_category.save
      render status: :ok, json: { success: 'Succssfully Created' }
    else
      render status: :unprocessable_entity, json: { errors: @beer_category.errors.full_messages.first }
    end

  end

  def edit

  end

  def update
    if @beer_category.update_attributes(beer_category_params)
      render status: :ok, json: { success: 'Succssfully updated' }
    else
      render status: :unprocessable_entity, json: { errors: @beer_category.errors.full_messages.first }
    end
  end

  def destroy
    @beer_category.destroy!
    redirect_to beers_path
  end

  private

  def set_beer_category
    @beer_category = BeerCategory.friendly.find params[:id]
  end

  def beer_category_params
    params.require(:beer_category).permit(:name)
  end

  def render_404
    render :template => 'error_pages/404', layout: 'admin', status: :not_found
  end

end
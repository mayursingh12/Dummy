class BeersController < ApplicationController

  # before_filter :authenticate_admin

  before_action :set_beer, only: [:edit, :update, :destroy]
  before_action :set_beer_category

  def index
    @beers = @beer_category.beers
  end

  def new
    @beer = Beer.friendly.new
  end

  def create
    @beer = Beer.friendly.new(beer_params)
    if BeerCategory.all.map(&:name).include?(params[:beer_category_id])
      if @beer.save
        render status: :ok, json: { success: 'Succssfully Created' }
        # flash[:success] = 'Beer Succssfully Created'
        # redirect_to action: :index
      else
        render status: :unprocessable_entity, json: { errors: @beer.errors.full_messages.first }
      #   render action: :new
      end
    else
      render_404
    end
  end

  def edit

  end

  def update
    if @beer.update_attributes(beer_params)
      render status: :ok, json: { success: 'Succssfully updated' }
      # flash[:success] = 'Successfully Updated'
      # redirect_to action: :index
    else
      render status: :unprocessable_entity, json: { errors: @beer.errors.full_messages.first }
      # render action: :edit
    end
  end

  def destroy
    @beer.destroy!
    redirect_to beers_path
  end

  private

  def set_beer
    beer = Beer.friendly.where(name: params[:id]).first
    if beer.present?
      @beer = beer
    else
      render status: :not_found, json: { errors: 'Result not found' }
    end
  end

  def set_beer_category
    beer_category = BeerCategory.friendly.where(name: params[:beer_category_id]).first
    if beer_category.present?
      @beer_category = beer_category
    else
      render status: :not_found, json: { errors: 'Result not found' }
    end

  end

  def beer_params
    params.require(:beer).permit(:name).merge(beer_category_id: @beer_category.id)
  end

  # def render_404
  #   render :template => 'error_pages/404', layout: 'admin', status: :not_found
  # end

end
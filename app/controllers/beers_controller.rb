class BeersController < ApplicationController

  # before_filter :authenticate_admin

  before_action :set_beer, only: [:edit, :update, :destroy]

  def index
    @beers = Beer.all
  end

  def new
    @beer = Beer.friendly.new
  end

  def create
    @beer = Beer.friendly.new(beer_params)
    if ['IPA', 'brown_ale', 'pilsner', 'lager', 'lambic', 'hefeweizen'].include?(@beer.name)
      if @beer.save
        flash[:success] = 'Beer Succssfully Created'
        redirect_to action: :index
      else
        render action: :new
      end
    else
      render_404
    end
  end

  def edit

  end

  def update
    if @beer.update_attributes(beer_params)
      flash[:success] = 'Successfully Updated'
      redirect_to action: :index
    else
      render action: :edit
    end
  end

  def destroy
    @beer.destroy!
    redirect_to beers_path
  end

  private

  def set_beer
    @beer = Beer.friendly.find params[:id]
  end

  def beer_params
    params.require(:beer).permit(:name)
  end

  def render_404
    render :template => 'error_pages/404', layout: 'admin', status: :not_found
  end

end
class RestaurantsController < ApplicationController
	before_filter :require_login, :except => [:index, :show]
	
	def index
		@restaurants = Restaurant.all

    if params[:category_choices]
      @category_array = Category.find(params[:category_choices]).restaurants
    end

    if params[:neighbourhood_choices]
      @neighbourhood_array = Restaurant.where("neighbourhood = ?", params[:neighbourhood_choices])
    end
	end

	def new
		@restaurant = Restaurant.new
	end

	def create
		@restaurant = Restaurant.new(restaurant_params)
		if @restaurant.save
			redirect_to restaurants_path(@restaurant)
		else
			render 'new'
		end
	end

	def edit
		@restaurant = Restaurant.find(params[:id])
	end

	def update
		@restaurant = Restaurant.find(params[:id])
		if @restaurant.update_attributes(restaurant_params)
			redirect_to restaurant_path(@restaurant)
		else
			render 'edit'
		end
	end

	def show
		@restaurant = Restaurant.find(params[:id])
		@reservation = current_user ? @restaurant.reservations.build : nil
	end

	def destroy
		@restaurant = Restaurant.find(params[:id])
		@restaurant.destroy
		redirect_to restaurants_path
	end

	private

	def restaurant_params
		params.require(:restaurant).permit(:name, :address, :neighbourhood, :category_id, :image, :capacity)
	end
end

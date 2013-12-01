class RestaurantsController < ApplicationController
	before_filter :require_login, :except => [:index, :show]
	
	
	def index

		if(params[:user_time_choices])
			user_time_choice = DateTime.new(params[:user_time_choices]["time_slot(1i)"].to_i, 
                        params[:user_time_choices]["time_slot(2i)"].to_i,
                        params[:user_time_choices]["time_slot(3i)"].to_i,
                        params[:user_time_choices]["time_slot(4i)"].to_i,
                        params[:user_time_choices]["time_slot(5i)"].to_i)
		else
			user_time_choice = (Time.zone.now + 1.hours).strftime("%I%p")
	  end

	  @filter_title = "Time: #{user_time_choice}"
	  @restaurants = Restaurant.all.select{|x| x.has_space(user_time_choice)}

	end

	def by_category
		category_choice = Category.find(params[:category_choices].to_i) 
		@filter_title = category_choice.name
		@restaurants = category_choice.restaurants
    
    respond_to do |format|
    	format.js {}
      format.html { redirect_to restaurants_path }
    end

  end

	def by_neighbourhood
		@filter_title = params[:neighbourhood_choice]
		@restaurants = Restaurant.where("neighbourhood = ?", params[:neighbourhood_choice])

    respond_to do |format|
    	format.js {}
      format.html { redirect_to restaurants_path }
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

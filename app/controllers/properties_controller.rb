class PropertiesController < ApplicationController
	before_action :sign_in_user, only: [:create, :edit, :update, :destroy]
  	before_action :correct_user, only: [:edit, :update, :destroy]
  	before_action :check_if_owner, only: [:new]


	def new
		@property = Property.new
	end

	def create
		@property = current_user.properties.build(property_params)
		if @property.save
			flash[:success] = "Property Created!"
			redirect_to property_path(@property)
		else
			render 'new'
		end
	end

	def show
		@property = Property.find(params[:id])
	rescue ActiveRecord::RecordNotFound
		flash[:notice] = "Property not found..."
		redirect_to properties_path
	end

	def index
		@properties = Property.paginate(page: params[:page])
	end

	def manage_properties
		if owner_user?
			#@properties = Property.paginate(page: params[:page])
			@properties = current_user.properties.paginate(page: params[:page])
		else
			redirect_to root_url
		end
	end

	def edit
		@property = Property.find(params[:id])
	end

	def update
		@property = Property.find(params[:id])
		if @property.update_attributes(property_params)
			flash[:success] = "Property updated"
			redirect_to @property
		else
			render 'edit'
		end
	end

	def destroy
		@property.destroy
		redirect_to properties_path
	end

	private

		def property_params
			params.require(:property).permit(:name, :description, :beds, :baths, :rent)
		end 

		#before filters

		def correct_user
			if owner_user?
				@property = current_user.properties.find_by(id: params[:id])
				if @property.nil?
					redirect_to root_url
				end
			else
				redirect_to root_url
			end
		end

		def check_if_owner
			if !owner_user?
				redirect_to root_url
			end
		end

		def sign_in_user
			unless signed_in?
				store_location
				redirect_to signin_url, notice: "Please sign in."
			end
		end
end

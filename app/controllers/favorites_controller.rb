class FavoritesController < ApplicationController

    def index
        @favorites = @current_user.favorites
    end

    def create
        @favorite = Favorite.create(favorite_params)
          if @favorite.valid?
            flash[:success] = "This home has been added to your favorites."
            redirect_to property_path(favorite_params[:property_id])
          else
            redirect_to @current_user
          end
      end

      def new
        @favorite = Favorite.new
      end

      def destroy
        @favorite = Favorite.find_by(user_id: @current_user.id)
        @favorite.destroy
        redirect_to @current_user
      end

      private

      def favorite_params
       params.require(:favorite).permit(:user_id, :property_id)
      end
end

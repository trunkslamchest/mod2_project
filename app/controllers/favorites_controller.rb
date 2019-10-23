class FavoritesController < ApplicationController

    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def index
        # @favorites = Favorite.find_by(user_id: @current_user.id)
        @favorites = @current_user.favorites
    end

    def create
        @favorite = Favorite.create(favorite_params)
          if @favorite.valid?
          flash[:success] = "This home has been added to your favorites."
          redirect_to @current_user
          end
      end

      def new
       @favorite = Favorite.new
      end

      private

      def favorite_params
       params.require(:favorite).permit(:user_id, :property_id)
      end
end

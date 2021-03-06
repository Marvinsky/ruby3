class UserController < ApplicationController
	def show
		@user = User.find(params[:id])
	end

	def follow
		respond_to do |format|
			if current_user.follow!(post_params[:friend_id])
				format.json {head :no_content}
			else
				format.json {render json: "Erros found", status: :unprocessable_entity }
			end
		end
	end


	private
	def post_params
		params.require(:user).permit(:friend_id)
	end
end
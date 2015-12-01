class PaymentsController < ApplicationController
	before_action :authenticate_user!

	def create
		@payment = current_user.payments.new(post_params)
		respond_to do |format|
			if @payment.save
				format.html {redirect_to shoppingcar_path}
				format.json {head :no_content}
			else
				redict_to Post.find(post_params[:post_id]), error: "The purchase could not be processed."
				format.json {head :no_content}
			end
		end
	end

	def shoppingcar
	end

	private
	def post_params
		params.require(:payment).permit(:post_id)
	end
end

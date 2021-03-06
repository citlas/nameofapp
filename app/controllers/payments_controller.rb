class PaymentsController < ApplicationController

	def create
		@product = Product.find(params[:product_id])
		@user = current_user
		# Get the credit card details submitted by the form
		token = params[:stripeToken]

		# Create the charge on Stripe's servers - this will charge the user's card
		begin
  		charge = Stripe::Charge.create(
		    :amount => (@product.price*100).to_i, 
		    :currency => "eur",
		    :source => token,
		    :description => params[:stripeEmail]
  		)

  		if charge.paid
  			Order.create(
  				product_id: @product.id,
  				user_id: @user.id,
  				total: @product.price
  				)
  		
  		end

		rescue Stripe::CardError => e
  		# The card has been declined
  		body = e.json_body
  		err = body[:error]
  		flash[:error] = "unfortunately, there was an error processing your payment: #{err[:message]}"

		end

		ActionMailer::Base.mail(:from => 'citlalli.prado@gmail.com',
			:to => @email,
			:subject => "Thanks for buying",
			:body => "You bought #{@product.name}, which is a #{@product.description} with a price of #{@product.price.to_s}").deliver_now


		redirect_to payments_created_path(@product)


	end


end

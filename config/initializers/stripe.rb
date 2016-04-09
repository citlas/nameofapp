if Rails.env.production?
	Rails.configuration.stripe = {
		:publishable_key => ENV['STRIPE_PUBLISHABLE_KEY'],
		:secret_key => ENV['STRIPE_SECRET_KEY']
	}
else
	Rails.configuration.stripe = {
		:publishable_key =>  'pk_test_7IBHmlGowbAoOYNFQW0dBtdD Roll Key',
		:secret_key => 'sk_test_Ht1CgFoWPPdjSa0tuqb5HIkI'
	}
end

Stripe.api_key = Rails.configuration.stripe[:secret_key]
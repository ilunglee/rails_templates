# Stripe Form Helper
module SpecStripeFormHelper

  # rubocop:disable Metrics/MethodLength
  def fill_stripe_elements(
    id: 'stripe-element', card: '4242424242424242',
    expiry: '1234', cvc: '123', postal: '12345'
  )
    using_wait_time(10) do
      frame = find("##{id} iframe")
      within_frame(frame) do
        card.to_s.chars.each do |piece|
          find_field('cardnumber').send_keys(piece)
        end

        find_field('exp-date').send_keys expiry
        find_field('cvc').send_keys cvc
        find_field('postal').send_keys postal
      end
    end
  end
  # rubocop:enable Metrics/MethodLength

end

RSpec.configure do |config|
  config.include SpecStripeFormHelper, type: :feature
end

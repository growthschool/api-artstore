module StripeWrapper
  class Token


  attr_reader :error_message, :response

#  def initalize#(number, exp_month, exp_year, csv)

#  end

  def initialize(options={})
    @response = options[:response]
    @error_message = options[:error_message]
  end

  def create
    begin
      response = Stripe::Token.create(
        :card => {
          :number => "4242424242424242",
          :exp_month => 5,
          :exp_year => 2017,
          :cvc => "314"
        } )
      Token.new(:response => response)
    rescue Stripe::CardError => e
      Token.new(:error_message => e.message)
    end
  end    


  def successful?
    @response.present?
  end

end

end
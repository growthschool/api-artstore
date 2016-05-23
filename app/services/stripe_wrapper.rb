module StripeWrapper
  class Token


  attr_reader :error_message, :response

  def initialize(options={})
    @number = options[:number]
    @cvc = options[:cvc]
    @exp_month = options[:exp_month]
    @exp_year = options[:exp_year]
    @response = options[:response]
    @error_message = options[:error_message]
  end

  def create
    begin
      response = Stripe::Token.create(
        :card => {
          :number => @number,
          :exp_month => @exp_month,
          :exp_year => 20,
          :cvc => @cvc
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
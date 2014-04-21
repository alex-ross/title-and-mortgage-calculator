class Calculation
  PROPERTIES = %w(house_price assess_value house_loan_in_percentage private_loan_in_percentage current_mortgage_deed)

  attr_accessor(*PROPERTIES)

  def initialize(attributes = {})
    attributes.each do |key, value|
      public_send("#{key}=", value) if PROPERTIES.member? key.to_s
    end
  end

  # Pantbrev
  def mortgage_deed
    mortgage_deed = (house_worth * (house_loan_in_percentage.to_f / 100.0))
    mortgage_deed -= current_mortgage_deed
    mortgage_deed = (mortgage_deed * 0.02).round
    [mortgage_deed, 0].max
  end

  # Lagfart
  def title_deed
    (house_worth * 0.015).round
  end

  def house_loan
    (house_price * (house_loan_in_percentage / 100.0)).round
  end

  def private_loan
    loan_decimal = private_loan_in_percentage / 100.0
    (house_price * loan_decimal).round
  end

  def contant_payment
    house_price - private_loan - house_loan
  end

  def house_worth
    [ house_price, assess_value ].max
  end

  def total_with_loans
    total_loan + total_without_loans
  end

  def total_loan
    private_loan + house_loan
  end

  def total_without_loans
    [mortgage_deed, title_deed, contant_payment].inject(:+)
  end

  def house_price=(value)
    @house_price = value.to_i
  end

  def assess_value=(value)
    @assess_value = value.to_i
  end

  def house_price
    @house_price ||= 0
    @house_price.round
  end

  def assess_value
    @assess_value ||= 0
  end

  def current_mortgage_deed=(value)
    @current_mortgage_deed = value.to_i
  end

  def house_loan_in_percentage=(value)
    @house_loan_in_percentage = value.to_i
  end

  def private_loan_in_percentage=(value)
    @private_loan_in_percentage = value.to_i
  end

end

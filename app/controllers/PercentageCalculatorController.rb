class PercentageCalculatorController < Formotion::FormController

  def viewDidLoad
    super

    self.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc
      .initWithBarButtonSystemItem UIBarButtonSystemItemDone, target: self,
                                                              action: 'submit'

  end

  def initWithDefaultForm
    self.initWithForm(form)
    self
  end

  def submit
    calculation = Calculation.new form.render
    controller = ResultController.alloc.initWithCalculation(calculation)
    self.navigationController.pushViewController controller, animated: true
  end

  def form
    return @form if @form

    @form = Formotion::Form.new persist_as: :form

    @form.build_section do |section|
      section.title = "Bolån i procent"

      section.build_row do |row|
        row.title = "Husets slutpris"
        row.type = :number
        row.key = :house_price
        row.input_accessory = :done
      end

      section.build_row do |row|
        row.title = "Taxeringsvärde"
        row.subtitle = "Valfritt"
        row.type = :number
        row.key = :assess_value
        row.input_accessory = :done
      end

      section.build_row do |row|
        row.title = "Bolån i procent"
        row.subtitle = "Upp till 85% är normalt."
        row.key = :house_loan_in_percentage
        row.type = :picker
        row.items = (0..100).to_a.map(&:to_s)
        row.value = "85"
        row.input_accessory = :done
      end

      section.build_row do |row|
        row.title = "Privatlån"
        row.subtitle = "Upp till 10% är normalt."
        row.key = :private_loan_in_percentage
        row.type = :picker
        row.items = (0..100).to_a.map(&:to_s)
        row.value = "10"
        row.input_accessory = :done
      end

      section.build_row do |row|
        row.title = "Nuvarande pantbrev"
        row.type = :number
        row.key = :current_mortgage_deed
        row.input_accessory = :done
      end
    end

    @form.build_section do |section|

      section.build_row do |row|
        row.title = "Räkna"
        row.type = :submit
      end
    end

    @form.on_submit do
      submit
    end

    @form
  end
end

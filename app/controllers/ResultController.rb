class ResultController < Formotion::FormController
  attr_accessor :calculation

  def viewDidLoad
    super

    self.title = "Resultat"
  end

  def initWithCalculation(calculation)
    self.initWithStyle(UITableViewStyleGrouped)
    self.calculation = calculation
    self.form = form
    self.tableView.allowsSelectionDuringEditing = true
    self
  end

  def form
    return @form if @form

    @form = Formotion::Form.new
    @form.build_section do |section|
      section.title = "Resultat"
      section.build_row do |row|
        row.title = "Pantbrev"
        row.type = :static
        row.value = formated_currency(calculation.mortgage_deed)
      end
      section.build_row do |row|
        row.title = "Lagfart"
        row.type = :static
        row.value = formated_currency(calculation.title_deed)
      end
      section.build_row do |row|
        row.title = "Egen kontantinsats"
        row.type = :static
        row.value = formated_currency(calculation.contant_payment)
      end
      section.build_row do |row|
        row.title = "Privatlån"
        row.type = :static
        row.value = formated_currency(calculation.private_loan)
      end
      section.build_row do |row|
        row.title = "Bolån"
        row.type = :static
        row.value = formated_currency(calculation.house_loan)
      end
    end

    @form.build_section do |section|
      section.title = "Totalt"
      section.build_row do |row|
        row.title = "Kontant"
        row.type = :static
        row.value = formated_currency(calculation.total_without_loans)
      end
      section.build_row do |row|
        row.title = "Lån"
        row.type = :static
        row.value = formated_currency(calculation.total_loan)
      end
      section.build_row do |row|
        row.title = "Totalt"
        row.type = :static
        row.value = formated_currency(calculation.total_with_loans)
      end
    end
    @form
  end

  def formated_currency(currency)
    "#{currency.to_s.reverse.gsub(/...(?=.)/,'\& ').reverse} kr"
  end
end

class PercentageCalculatorController < UIViewController

  def viewDidLoad
    super

    self.title = "Bolån i procent"

    self.view.backgroundColor = UIColor.whiteColor

    @housePriceLabel = label("Husets slutpris")
    @housePriceInput = inputField(keyboardType: UIKeyboardTypeNumberPad)

    @assessValueLabel = label("Taxeringsvärde (valfritt)")
    @assessValueInput = inputField(keyboardType: UIKeyboardTypeNumberPad)

    @mortgageLabel = label("Bolån i procent")
    @mortgageInput = inputField(keyboardType: UIKeyboardTypeDecimalPad)

    @currentMortgageDeedLabel = label "Nuvarande belopp på pantbrev"
    @currentMortgageDeedInput = inputField(keyboardType: UIKeyboardTypeNumberPad)

    buildLayout
  end

  def label(text)
    label = UILabel.alloc.initWithFrame [[0,0], [160, 20]]
    label.textAlignment = UITextAlignmentCenter
    label.text = text
    label
  end

  #  Keyboard layouts
  #  ----------------
  #  UIKeyboardTypeDefault,                // Default type for the current input method.
  #  UIKeyboardTypeASCIICapable,           // Displays a keyboard which can enter ASCII characters, non-ASCII keyboards remain active
  #  UIKeyboardTypeNumbersAndPunctuation,  // Numbers and assorted punctuation.
  #  UIKeyboardTypeURL,                    // A type optimized for URL entry (shows . / .com prominently).
  #  UIKeyboardTypeNumberPad,              // A number pad (0-9). Suitable for PIN entry.
  #  UIKeyboardTypePhonePad,               // A phone pad (1-9, *, 0, #, with letters under the numbers).
  #  UIKeyboardTypeNamePhonePad,           // A type optimized for entering a person's name or phone number.
  #  UIKeyboardTypeEmailAddress,           // A type optimized for multiple email address entry (shows space @ . prominently).
  #  UIKeyboardTypeDecimalPad,             // A number pad including a decimal point
  #  UIKeyboardTypeTwitter,                // Optimized for entering Twitter messages (shows # and @)
  #  UIKeyboardTypeWebSearch,              // Optimized for URL and search term entry (shows space and .)
  def inputField(options = {})
    field = UITextField.alloc.initWithFrame [[0,0], [160, 26]]
    field.placeholder = options[:placeholder] if options[:placeholder]
    field.setKeyboardType options[:keyboardType] if options[:keyboardType]
    field.textAlignment = UITextAlignmentCenter
    field.autocapitalizationType = UITextAutocapitalizationTypeNone
    field.borderStyle = UITextBorderStyleRoundedRect
    field
  end

  def buildLayout
    fields = %w(housePrice assessValue mortgage currentMortgageDeed)
    subviews = fields.each_with_object({}) do |field, hash|
      hash["#{field}Label"] = instance_variable_get("@#{field}Label")
      hash["#{field}Input"] = instance_variable_get("@#{field}Input")
    end

    verticalFieldLayouts = fields.map do |field|
      %W(
        [#{field}Label(==labelHeight)]
        -labelMargin-
        [#{field}Input(==inputHeight)]
      ).join("")
    end

    Motion::Layout.new do |layout|
      layout.view view
      layout.subviews subviews
      layout.metrics "top" => 100,
                     "margin" => 20,
                     "inputHeight" => 40,
                     "labelMargin" => 5,
                     "labelHeight" => 30
      layout.vertical "|-top-#{verticalFieldLayouts.join("-margin-")}"
      fields.each do |field|
        layout.horizontal "|-margin-[#{field}Label]-margin-|"
        layout.horizontal "|-margin-[#{field}Input]-margin-|"
      end
    end
  end
end

module MailForm
  class Base
    include ActiveModel::Conversion
    extend  ActiveModel::Naming
    extend  ActiveModel::Translation
    extend ActiveModel::Callbacks
    include ActiveModel::Validations
    include MailForm::Validators
    include ActiveModel::AttributeMethods # attributes method behavior
    attribute_method_prefix 'clear_'      # clear_ is attribute prefix
    attribute_method_suffix '?'

    # When we use class_attribute it automatically works with inheritance, 
    # so if a class inherits from this it will inherit the attributes too
    class_attribute :attribute_names
    self.attribute_names = []

    define_model_callbacks :deliver

    def initialize(attributes = {})
      attributes.each do |attr, value|
        self.public_send("#{attr}=", value)
      end
    end

    def self.attributes(*names)
      attr_accessor(*names)
      define_attribute_methods(names)

      self.attribute_names += names
    end

    def persisted?
      false
    end

    def deliver
      if valid?
        run_callbacks do
          MailForm::Notifier.contact(self).deliver
        end
      else
        false
      end
    end
    
    protected

    def clear_attribute(attribute)
      send("#{attribute}=", nil)
    end

    def attribute?(attribute)
      send(attribute).present?
    end
  end
end

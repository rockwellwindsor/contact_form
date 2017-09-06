module MailForm
  module Validators
    class AbsenceValidator < ActiveModel::EachValidator
      def validate_each(record, attribute, value)
        record.erros.add(attribute, :invalid, options) unless value.blank?
      end
    end
  end
end

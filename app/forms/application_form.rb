# frozen_string_literal: true

# Base class for form objects.
class ApplicationForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations::Callbacks # before_validation, after_validation

  FORM_CLASS_SUFFIX = 'Form'

  def self.model_name
    # Remove the "Form" suffix from the class name.
    # This allows Rails magic such as route paths.
    model_name = method(:model_name).super_method.call.to_s
    ActiveModel::Name.new(self, nil, model_name.delete_suffix(FORM_CLASS_SUFFIX))
  end

  # @param save [Boolean] whether the form is being used to save the channel
  def valid?(save: false)
    @save = save
    super
  end

  # This can be used to control validations specific to save.
  # For example: validates :channel_id, presence: { message: 'requires channel id' }, if: :save?
  def save?
    @save
  end
end

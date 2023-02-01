class MinCreditsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if record.user.credits < 1
      record.errors.add attribute, "not_enough_credits"
    end
  end
end

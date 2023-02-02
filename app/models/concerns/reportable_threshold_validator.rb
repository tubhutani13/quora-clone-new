class ReportableThresholdValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if record.abuse_reports.count >= ABUSE_REPORTS_THRESHOLD
      record.errors.add attribute, "not publishable"
    end
  end
end

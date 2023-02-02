module AbuseReportsHandler
  def self.included(klass)
    klass.class_eval do
      has_many :reports, as: :reportable
      validates :published_at, reportable_threshold: true, if: :published_at?
    end
  end

  def unpublish
    update(published_at: nil)
  end
end

class Comment < ApplicationRecord
  include ReportsHandler
  
  before_create :set_publish_time
  
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates_presence_of :content

  def set_publish_time
    self.published_at = Time.now
  end
end

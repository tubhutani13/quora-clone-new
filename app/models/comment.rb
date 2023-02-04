class Comment < ApplicationRecord
  include ReportsHandler

  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates_presence_of :content
end

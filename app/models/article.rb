class Article < ApplicationRecord
  has_many :comments

  validates_presence_of :title, :text
end

class Article < ApplicationRecord
  validates_presence_of :title, :text
  
  has_many :comments
end

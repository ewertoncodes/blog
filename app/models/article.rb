class Article < ApplicationRecord
  validates_presence_of :title, :text
end

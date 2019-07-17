class Comment < ApplicationRecord
  validates_presence_of :body

  belongs_to :article  
end

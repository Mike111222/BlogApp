class Like < ApplicationRecord
  belongs_to :userId
  belongs_to :postId
end

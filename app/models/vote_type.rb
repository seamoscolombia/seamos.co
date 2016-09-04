class VoteType < ApplicationRecord
  validates :code, presence: true
end

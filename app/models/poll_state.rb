class PollState < ApplicationRecord
  belongs_to :poll
  enum status: {rejected: 0, neutro: 1, approved: 2}
end

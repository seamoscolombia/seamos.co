class Vote < ApplicationRecord
  belongs_to :poll
  belongs_to :usuario
  belongs_to :vote_type
end

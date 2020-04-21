class Record < ApplicationRecord
  validates :ip, presence: true, uniqueness: true
end

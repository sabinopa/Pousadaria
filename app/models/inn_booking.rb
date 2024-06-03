class InnBooking < ApplicationRecord
  belongs_to :inn

  validates :name, :start_date, :end_date, presence: true
end

class Trip < ApplicationRecord
  belongs_to :user
  
  enum status: {
    PLANNED: 'PLANNED',
    ONGOING: 'ONGOING',
    DELAYED: 'DELAYED',
    CANCELLED: 'CANCELLED'
  }

  validates :starts_at, :name, presence: true
end

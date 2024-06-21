class Order < ApplicationRecord
  belongs_to :product

  enum status: { pending: 'pending', complete: 'complete' }
end
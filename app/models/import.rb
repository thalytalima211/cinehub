class Import < ApplicationRecord
  belongs_to :user
  has_one_attached :file

  enum :status, { pending: 'pending', processing: 'processing', completed: 'completed', failed: 'failed' }
end

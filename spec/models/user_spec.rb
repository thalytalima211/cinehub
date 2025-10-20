require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid' do
    it 'missing params' do
      user = User.create name: ''

      expect(user).not_to be_valid
      expect(user.errors).to include :name
    end

    it { should validate_length_of(:name).is_at_most 50 }
  end
end

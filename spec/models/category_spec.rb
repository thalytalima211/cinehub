require 'rails_helper'

RSpec.describe Category, type: :model do
  describe '#valid' do
    it 'missing params' do
      category = Category.new name: ''

      expect(category).not_to be_valid
      expect(category.errors).to include :name
    end

    it { should validate_length_of(:name).is_at_most 50 }
  end
end

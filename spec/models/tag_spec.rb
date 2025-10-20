require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe '#valid' do
    it 'missing params' do
      tag = Tag.new name: ''

      expect(tag).not_to be_valid
      expect(tag.errors).to include :name
    end

    it { should validate_length_of(:name).is_at_most 50 }
  end
end

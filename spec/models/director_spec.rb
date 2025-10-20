require 'rails_helper'

RSpec.describe Director, type: :model do
  describe '#valid' do
    it 'missing params' do
      director = Director.new name: ''

      expect(director).not_to be_valid
      expect(director.errors).to include :name
    end

    it { should validate_length_of(:name).is_at_most 50 }
  end
end

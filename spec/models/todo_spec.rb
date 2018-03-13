# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Todo, type: :model do
  let(:todo) do
    create(:todo)
  end

  context 'associations' do
    it { should belong_to(:user) }
  end

  context 'validations' do
    subject { build(:todo) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:user_id) }
  end

  specify 'factory' do
    expect(todo.valid?).to be_truthy
  end
end

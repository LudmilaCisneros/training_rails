require 'rails_helper'

describe Rent, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:book) }
  it {  should validate_presence_of(:from) }
  it {  should validate_presence_of(:to) }

  subject(:rent) do
    create(:rent)
  end

  it { is_expected.to be_valid }

  describe '#create' do
    context 'When the user is nil' do
      subject { build(:rent, user: nil) }
      it { is_expected.to be_invalid }
    end

    context 'When the book is nil' do
      subject { build(:rent, book: nil) }
      it { is_expected.to be_invalid }
    end

    context 'When the from is nil' do
      subject { build(:rent, from: nil) }
      it { is_expected.to be_invalid }
    end

    context 'When the to is nil' do
      subject { build(:rent, to: nil) }
      it { is_expected.to be_invalid }
    end
  end
end

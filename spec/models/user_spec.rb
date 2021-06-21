require 'rails_helper'

describe User, type: :model do
  it { should validate_presence_of(:email) }
  it {  should validate_presence_of(:password) }
  it {  should validate_presence_of(:password_confirmation) }
  it {  should validate_presence_of(:first_name) }
  it {  should validate_presence_of(:last_name) }

  subject(:user) do
    create(:user)
  end

  it { is_expected.to be_valid }

  describe '#create' do
    context 'When the password is longer than 128 chars' do
      let(:passwordFake) { Faker::Lorem.characters(number: 130) }
      subject { build(:user, password: passwordFake) }
      it { is_expected.to be_invalid }
    end

    context 'When the password is shorter than 6 chars' do
      let(:fake_password) { Faker::Lorem.characters(number: 4) }
      subject { build(:user, password: fake_password) }
      it { is_expected.to be_invalid }
    end

    context "When password and password confirmation don't match" do
      subject { build(:user) }
      it { expect(user).to validate_confirmation_of(:password) }
    end

    context 'When the email is nil' do
      subject { build(:user, email: nil) }
      it { is_expected.to be_invalid }
    end

    context 'When the password is nil' do
      subject { build(:user, password: nil) }
      it { is_expected.to be_invalid }
    end

    context 'When the password_confirmation is nil' do
      subject { build(:user, password_confirmation: nil) }
      it { is_expected.to be_invalid }
    end

    context 'When the first_name is nil' do
      subject { build(:user, first_name: nil) }
      it { is_expected.to be_invalid }
    end

    context 'When the last_name is nil' do
      subject { build(:user, last_name: nil) }
      it { is_expected.to be_invalid }
    end
  end
end

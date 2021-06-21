require 'rails_helper'

describe Book, type: :model do
  it {  should validate_presence_of(:genre) }
  it {  should validate_presence_of(:author) }
  it {  should validate_presence_of(:image) }
  it {  should validate_presence_of(:title) }
  it {  should validate_presence_of(:publisher) }
  it {  should validate_presence_of(:year) }

  #--with Factory_bot--
  subject(:book) do
    create(:book)
  end

  #--without Factory_bot--
  # subject(:book) do
  # Book.new(
  #    genre: genre, author: author, image: image, title: title,
  #    publisher: publisher, year: year
  #  )
  # end

  # let(:genre)            { Faker::Name.genre }
  # let(:author)           { Faker::Name.author }
  # let(:image)            { Faker::Name.image }
  # let(:title)            { Faker::Name.title }
  # let(:publisher)        { Faker::Name.publisher }
  # let(:year)             { Faker::Name.year }

  it { is_expected.to be_valid }

  describe '#create' do
    context 'When the genre is nil' do
      subject { build(:book, genre: nil) }
      it { is_expected.to be_invalid }
    end

    context 'When the author is nil' do
      subject { build(:book, author: nil) }
      it { is_expected.to be_invalid }
    end

    context 'When the image is nil' do
      subject { build(:book, image: nil) }
      it { is_expected.to be_invalid }
    end

    context 'When the title is nil' do
      subject { build(:book, title: nil) }
      it { is_expected.to be_invalid }
    end

    context 'When the publisher is nil' do
      subject { build(:book, publisher: nil) }
      it { is_expected.to be_invalid }
    end

    context 'When the year is nil' do
      subject { build(:book, year: nil) }
      it { is_expected.to be_invalid }
    end
  end
end

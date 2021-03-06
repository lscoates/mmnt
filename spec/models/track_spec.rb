require "rails_helper"

describe Track, "associations" do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:moments) }

  context "moments" do
    let(:track) { create(:track) }
    let!(:moment1) do
      create(
        :moment,
        original_date: Time.zone.parse("Jan 20 2020"),
        track: track
      )
    end
    let!(:moment2) do
      create(
        :moment,
        original_date: Time.zone.parse("Mar 12 2020"),
        track: track
      )
    end

    it "orders the moments by the original_date ascending" do
      expect(track.moments).to match([moment2, moment1])
    end
  end
end

describe Track, "validations" do
  it { should validate_presence_of(:user) }

  context "name uniqueness" do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let!(:track1) { create(:track, name: "Career", user: user1) }

    it "is valid when the name is unique" do
      new_track = Track.new(name: "Family", user: user2)
      expect(new_track).to be_valid
    end

    it "is valid when the name is in use by another user" do
      new_track = Track.new(name: "Career", user: user2)
      expect(new_track).to be_valid
    end

    it "is invalid when the name is missing" do
      new_track = Track.new(name: nil, user: user1)
      expect(new_track).to be_invalid
    end

    it "is invalid when the name is an empty string" do
      new_track = Track.new(name: "", user: user1)
      expect(new_track).to be_invalid
    end

    it "is invalid when the name is in use by the same user" do
      new_track = Track.new(name: "Career", user: user1)
      expect(new_track).to be_invalid
    end

    it "is case insensitive when checking for uniqueness" do
      new_track = Track.new(name: "career", user: user1)
      expect(new_track).to be_invalid
    end
  end
end

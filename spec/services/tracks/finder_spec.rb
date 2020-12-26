require "rails_helper"

describe Tracks::Finder, ".tracks_for_user" do
  let(:user) { create(:user) }
  let!(:track1) { create(:track, user: user) }
  let!(:track2) { create(:track, user: user) }
  let!(:track3) { create(:track) }

  subject { described_class.tracks_for_user(user) }

  it "returns all associated tracks for the user" do
    expect(subject).to match([track1, track2])
  end

  it "returns an active record association" do
    expect(subject).to be_a(
      ActiveRecord::Associations::CollectionProxy
    )
  end
end

describe Tracks::Finder, ".track_for_user" do
  let(:user) { create(:user) }
  let!(:track1) { create(:track, user: user) }
  let!(:track2) { create(:track, user: user) }
  let!(:track3) { create(:track) }

  subject { described_class.track_for_user(user, track1.id) }

  it "returns the correct track" do
    expect(subject).to eql(track1)
  end

  it "includes the track's moments" do
    expect(user)
      .to receive_message_chain(:tracks, :includes)
      .with(:moments)
      .and_return(user.tracks)

    subject
  end

  context "when the track id doesn't exist" do
    subject { described_class.track_for_user(user, 999) }

    it "returns nil" do
      expect(subject).to eql(nil)
    end
  end

  context "when the track id belongs to another user" do
    subject { described_class.track_for_user(user, track3.id) }

    it "returns nil" do
      expect(subject).to eql(nil)
    end
  end
end

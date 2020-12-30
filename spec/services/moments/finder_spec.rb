require "rails_helper"

describe Moments::Finder, ".moments_for_track" do
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
  let!(:moment3) { create(:moment) }

  subject { described_class.moments_for_track(track) }

  it "returns moments for track, ordered by the original_date" do
    expect(subject).to match([moment2, moment1])
  end

  it "returns an active record association" do
    expect(subject).to be_a(
      ActiveRecord::Associations::CollectionProxy
    )
  end
end

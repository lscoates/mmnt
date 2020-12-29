require "rails_helper"

describe Moments::Creator, "#call" do
  let(:track) { create(:track) }
  let(:result) { described_class.new(track: track, params: params).call }

  context "when the params are valid" do
    let(:params) do
      {
        body: "Once upon a time...",
        original_date: "2020-12-20T00:10:00-08:00",
      }
    end

    it "creates a new moment" do
      expect(result.success?).to eql(true)
      expect(result.data).to be_a(Moment)
      expect(track.moments.count).to eql(1)
      expect(result.data.original_date)
        .to eql(Time.zone.parse("2020-12-20T00:10:00-08:00"))
    end
  end

  context "when the params are nil" do
    let(:params) { nil }

    it "returns an error" do
      expect(result.success?).to eql(false)
      expect(result.data.size).to eql(1)
      expect(result.data[:body]).to match(["can't be blank"])
    end
  end
end

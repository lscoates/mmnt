require "rails_helper"
require "mini_magick"

describe Moments::Creator, "#call" do
  let(:track) { create(:track) }
  let(:result) { described_class.new(track: track, params: params).call }

  context "when the params are valid" do
    let(:params) do
      {
        title: "A moment",
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

  context "when a feature image is provided" do
    let(:params) do
      {
        title: "A moment",
        body: "Once upon a time...",
        original_date: "2020-12-20T00:10:00-08:00",
        feature_image: fixture_file_upload("images/bible-1200x1500.jpg", "image/jpeg")
      }
    end

    it "creates a new moment with the attached image" do
      image_before_upload = MiniMagick::Image.open(params[:feature_image].tempfile.path)
      expect(image_before_upload).to have_attributes(
        width: 2000,
        height: 1500
      )

      expect(result.success?).to eql(true)
      expect(result.data).to be_a(Moment)
      expect(track.moments.count).to eql(1)
      expect(result.data.feature_image).to be_attached

      image_after_upload = MiniMagick::Image.open(result.data.feature_image)
      expect(image_after_upload).to have_attributes(
        width: 1200,
        height: 900
      )
    end
  end

  context "when the params are nil" do
    let(:params) { nil }

    it "returns an error" do
      expect(result.success?).to eql(false)
      expect(result.data.size).to eql(2)
      expect(result.data[:title]).to match(["can't be blank"])
      expect(result.data[:body]).to match(["can't be blank"])
    end
  end
end

require "rails_helper"
require "mini_magick"

describe Moments::Updater, "#call" do
  let(:moment) { create(:moment) }
  let(:result) { described_class.new(moment: moment, params: params).call }

  context "when the params are valid" do
    let(:params) do
      {
        title: "A moment",
      }
    end

    it "updates the moment" do
      expect { expect(result).to be_success }
        .to change { moment.reload.title }.to("A moment")
    end
  end

  context "when a feature image is provided" do
    let(:params) do
      {
        title: "A moment",
        feature_image: fixture_file_upload("images/bible-1200x1500.jpg", "image/jpeg")
      }
    end

    it "creates a new moment with the attached image" do
      image_before_upload = MiniMagick::Image.open(params[:feature_image].tempfile.path)
      expect(image_before_upload).to have_attributes(
        width: 2000,
        height: 1500
      )

      expect { expect(result).to be_success }
        .to change { moment.reload.title }.to("A moment")
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

    it "returns successfully without changes" do
      expect { expect(result).to be_success }
        .to not_change { moment.reload }
    end
  end

  context "when the update fails" do
    let(:params) do
      {
        title: nil,
      }
    end

    it "returns an error" do
      expect { expect(result).to_not be_success }
        .to not_change { moment.reload.title }
      expect(result.errors.full_messages).to eql(["Title can't be blank"])
    end
  end
end

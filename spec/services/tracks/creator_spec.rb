require "rails_helper"

describe Tracks::Creator, "#call" do
  let(:user) { create(:user) }
  let(:result) { described_class.new(user: user, params: params).call }

  context "when the params are valid" do
    let(:params) { { name: "Career" } }

    it "creates a new track" do
      expect(result.success?).to eql(true)
      expect(result.data).to be_a(Track)
      expect(user.tracks.count).to eql(1)
    end
  end

  context "when the params are nil" do
    let(:params) { nil }

    it "returns an error" do
      expect(result.success?).to eql(false)
      expect(result.data.size).to eql(1)
      expect(result.data[:name]).to match(["can't be blank"])
    end
  end

  context "when the params are an empty hash" do
    let(:params) { {} }

    it "returns an error" do
      expect(result.success?).to eql(false)
      expect(result.data.size).to eql(1)
      expect(result.data[:name]).to match(["can't be blank"])
    end
  end

  context "when the params are invalid" do
    let(:params) { { name: "Career" } }

    it "returns an error" do
      create(:track, name: "Career", user: user)

      expect(result.success?).to eql(false)
      expect(result.data.size).to eql(1)
      expect(result.data[:name]).to match(["has already been taken"])
    end
  end
end

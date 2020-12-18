require "rails_helper"

describe TracksController, type: :controller do
  context "when the user is not authenticated" do
    it "returns a 302 error" do
      get :index

      expect(response.status).to eql(302)
    end
  end

  describe "GET index" do
    let(:user) { create(:user) }
    let!(:track1) { create(:track, user: user) }
    let!(:track2) { create(:track, user: user) }
    let!(:track3) { create(:track) }

    before { sign_in user }

    it "assigns a list of tracks that belong to the user" do
      get :index

      expect(response.status).to eql(200)
      expect(assigns(:tracks)).to match([track1, track2])
    end
  end
end

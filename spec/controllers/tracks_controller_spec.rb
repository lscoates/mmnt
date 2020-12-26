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

    before { sign_in(user) }

    it "assigns a list of tracks that belong to the user" do
      get :index

      expect(response.status).to eql(200)
      expect(assigns(:tracks)).to match([track1, track2])
    end
  end

  describe "GET show" do
    let(:track) { create(:track) }
    let(:user) { track.user }

    before { sign_in(user) }

    it "assigns the correct track" do
      get :show, params: { id: track.id }

      expect(response.status).to eql(200)
      expect(assigns(:track)).to eql(track)
    end

    it "returns a 404 when the track can't be found" do
      get :show, params: { id: 999 }

      expect(response.status).to eql(404)
      expect(assigns(:track)).to eql(nil)
    end
  end

  describe "POST create" do
    let(:user) { create(:user) }

    before { sign_in(user) }

    context "when the params are valid" do
      let(:params) do
        {
          name: "Career",
        }
      end

      it "creates a new track" do
        expect { post :create, params: { track: params, format: :json  } }
          .to change { user.tracks.count }.by(1)
        expect(response.status).to eql(201)
      end
    end

    context "when the params are invalid" do
      let(:params) do
        {
          name: "",
        }
      end

      it "returns an error" do
        expect { post :create, params: { track: params, format: :json  } }
          .not_to change { user.tracks.count }
        expect(response.status).to eql(422)
        expect(JSON.parse(response.body)["errors"].size).to eql(1)
      end
    end
  end
end

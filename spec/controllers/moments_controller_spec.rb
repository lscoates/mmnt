require "rails_helper"

describe MomentsController, type: :controller do
  let(:track) { create(:track) }

  context "when the user is not authenticated" do
    it "returns a 302 error" do
      get :new, params: { track_id: track.id }

      expect(response.status).to eql(302)
    end
  end

  describe "POST create" do
    let(:user) { track.user }

    before { sign_in user }

    context "when the params are valid" do
      let(:params) do
        {
          body: "Once upon a time...",
        }
      end

      it "creates a new track" do
        expect { post :create, params: { track_id: track.id, moment: params, format: :json  } }
          .to change { track.moments.count }.by(1)
        expect(response.status).to eql(201)
      end
    end

    context "when the params are invalid" do
      let(:params) do
        {
          body: "",
        }
      end

      it "returns an error" do
        expect { post :create, params: { track_id: track.id, moment: params, format: :json  } }
          .not_to change { track.moments.count }
        expect(response.status).to eql(422)
        expect(JSON.parse(response.body)["errors"].size).to eql(1)
      end
    end
  end
end

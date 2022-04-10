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
          title: "A moment",
          body: "Once upon a time...",
          original_date: "2020-12-15T12:00:00-08:00",
        }
      end

      it "creates a new track" do
        expect { post :create, params: { track_id: track.id, moment: params } }
          .to change { track.moments.count }.by(1)
        expect(response.status).to eql(302)
      end
    end

    context "when the body is missing" do
      let(:params) do
        {
          title: "A moment",
          body: "",
        }
      end

      it "returns an error" do
        expect { post :create, params: { track_id: track.id, moment: params } }
          .not_to change { track.moments.count }
        expect(response.status).to eql(422)
        expect(assigns[:errors].full_messages).to eql(["Body can't be blank"])
      end
    end

    context "when the title is missing" do
      let(:params) do
        {
          title: "",
          body: "Once upon a time...",
        }
      end

      it "returns an error" do
        expect { post :create, params: { track_id: track.id, moment: params } }
          .not_to change { track.moments.count }
        expect(response.status).to eql(422)
        expect(assigns[:errors].full_messages).to eql(["Title can't be blank"])
      end
    end
  end
end

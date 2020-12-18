require "rails_helper"

feature "Viewing a user's tracks", type: :feature do
  context "when the user is not logged in" do
    scenario "they are redirected" do
      visit "/tracks"

      assert_text(:visible, "Log in")
    end
  end

  context "when the user is logged in" do
    let(:user) { create(:user) }
    let!(:track1) { create(:track, name: "Career", user: user) }
    let!(:track2) { create(:track, name: "Family", user: user) }
    let!(:track3) { create(:track, name: "Hobbies") }

    before { sign_in user }

    scenario "they are redirected" do
      visit "/tracks"

      assert_text(:visible, "Career")
      assert_text(:visible, "Family")
      assert_text(:not_visible, "Hobbies")
    end
  end
end

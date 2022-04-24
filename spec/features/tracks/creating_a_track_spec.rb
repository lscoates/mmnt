require "rails_helper"

feature "Creating a new track", type: :feature do
  context "when the user is not logged in" do
    scenario "they are redirected" do
      visit "/tracks/new"

      assert_text(:visible, "Log in")
    end
  end

  context "when the user is logged in", js: true do
    let(:user) { create(:user) }
    let!(:track1) { create(:track, name: "Career", user: user) }

    before { sign_in user }

    scenario "successfully creating a new track" do
      expect {
        visit "/tracks"

        assert_text(:visible, "Career")
        click_link "New Track"

        fill_in "Name", with: "Family"
        click_button "Create Track"
      }.to change { user.reload.tracks.count }.by(1)
    end

    scenario "when the form data is invalid" do
      visit "/tracks"

      assert_text(:visible, "Career")
      click_link "New Track"

      fill_in "Name", with: "Career"
      click_button "Create Track"

      assert_text(:visible, "has already been taken")
    end
  end
end

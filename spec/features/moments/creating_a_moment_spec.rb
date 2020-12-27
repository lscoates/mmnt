require "rails_helper"

feature "Creating a new moment", type: :feature do
  let(:user) { create(:user) }
  let!(:track) { create(:track, name: "Career", user: user) }

  context "when the user is not logged in" do
    scenario "they are redirected" do
      visit "/tracks/#{track.id}/moments/new"

      assert_text(:visible, "Log in")
    end
  end

  context "when the user is logged in", js: true do
    before { sign_in user }

    scenario "successfully creating a new moment" do
      visit "/tracks/#{track.id}"

      click_link "New Moment"

      fill_in "Describe your moment...", with: "Once upon a time..."
      click_button "Create Moment"

      assert_text(:visible, "New moment successfully created!")
    end

    scenario "when the form data is invalid" do
      visit "/tracks/#{track.id}/moments/new"

      fill_in "Describe your moment...", with: ""
      click_button "Create Moment"

      assert_text(:visible, "can't be blank")
    end
  end
end

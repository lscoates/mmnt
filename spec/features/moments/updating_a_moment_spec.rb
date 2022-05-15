require "rails_helper"

feature "Updating a new moment", type: :feature do
  let(:user) { create(:user) }
  let(:track) { create(:track, user: user) }
  let!(:moment) { create(:moment, title: "The moment!", track: track) }

  context "when the user is not logged in" do
    scenario "they are redirected" do
      visit edit_track_moment_path(track, moment)

      assert_text(:visible, "Log in")
    end
  end

  context "when the user is logged in", js: true do
    before { sign_in user }

    scenario "successfully editing a moment" do
      expect {
        visit track_path(track)

        click_link "edit"

        fill_in "Title", with: "An updated moment"
        find("trix-editor").click.set("Once upon a time...")

        fill_in "moment_original_date", with: Date.current

        click_button "Update Moment"
      }.to change { moment.reload.title }.to("An updated moment")
    end

    scenario "successfully editing a moment with a new photo" do
      expect {
        visit track_path(track)

        click_link "edit"

        attach_file(
          "moment_feature_image",
          Rails.root + "spec/fixtures/files/images/bible-1200x1500.jpg"
        )

        click_button "Update Moment"
      }.to change { moment.reload.feature_image.blob }
    end

    scenario "when the form data is invalid" do
      visit edit_track_moment_path(track, moment)

      find("trix-editor").click.set(" ")

      click_button "Update Moment"

      assert_text(:visible, "can't be blank")
    end
  end
end

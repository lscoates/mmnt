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

      fill_in "Title", with: "A moment"
      find("trix-editor").click.set("Once upon a time...")

      find(:css, "div.SingleDatePicker").click
      assert_text(:visible, Date.today.strftime("%B"))
      find_all(:css, "td.CalendarDay").first.click

      click_button "Create Moment"

      assert_text(:visible, "New moment successfully created!")
    end

    scenario "successfully creating a new moment with a photo" do
      visit "/tracks/#{track.id}"

      click_link "New Moment"

      attach_file(
        "feature_image",
        Rails.root + "spec/fixtures/images/bible-1200x1500.jpg"
      )

      fill_in "Title", with: "A moment"
      find("trix-editor").click.set("Once upon a time...")

      find(:css, "div.SingleDatePicker").click
      assert_text(:visible, Date.today.strftime("%B"))
      find_all(:css, "td.CalendarDay").first.click

      click_button "Create Moment"

      assert_text(:visible, "New moment successfully created!")
    end

    scenario "when the form data is invalid" do
      visit "/tracks/#{track.id}/moments/new"

      find("trix-editor").click.set("")
      click_button "Create Moment"

      assert_text(:visible, "can't be blank")
    end
  end
end

require "rails_helper"

feature "Viewing a specific track", type: :feature do
  let(:user) { create(:user) }
  let!(:track1) { create(:track, name: "Career", user: user) }
  let!(:track2) { create(:track, name: "Family", user: user) }
  let!(:track3) { create(:track, name: "Hobbies") }

  context "when the user is not logged in" do
    scenario "they are redirected" do
      visit "/tracks/#{track1.id}"

      assert_text(:visible, "Log in")
    end
  end

  context "when the user is logged in" do
    before { sign_in user }

    scenario "viewing a track with no moments" do
      visit "/tracks/#{track1.id}"

      assert_text(:visible, "Career")
      assert_text(:visible, "Track your first moment!")

      assert_no_text(:visible, "Family")
      assert_no_text("Hobbies")
    end

    scenario "viewing a track with moments" do
      create(:moment, track: track1, content: "Once upon a time...")

      visit "/tracks/#{track1.id}"

      assert_text(:visible, "Career")
      assert_text(:visible, "Once upon a time...")

      assert_no_text(:visible, "Track your first moment!")
      assert_no_text(:visible, "Family")
      assert_no_text("Hobbies")
    end

    scenario "navigating to a track from the index" do
      visit "/tracks"

      click_link "Career"

      assert_text(:visible, "Career")
      assert_text(:visible, "Track your first moment!")

      assert_no_text(:visible, "Family")
      assert_no_text("Hobbies")
    end
  end
end

require "rails_helper"

RSpec.describe "Activities" do
  let(:user) { create :user }

  before { sign_in(user) }

  scenario "user creates activity from list" do
    visit root_path
    find('div#trigger-user-options').click
    click_link "Manage Activities"
    click_link "New activity"
    fill_in "activity_name", with: "Task"
    fill_in "activity_description", with: "A custom task"
    click_button "Save"
    expect(user.activities.count).to eq(1)
  end

  context "with an activity" do
    let(:activity) { create :activity, user: user }

    before do
      activity
      visit root_path
      find('div#trigger-user-options').click
    end

    describe "index" do
      before { visit activities_path }

      it("displays activity name") { expect(page).to have_text(activity.name) }
      it("displays edit link") { expect(page).to have_link(href: edit_activity_path(activity)) }
      it("displays destroy button") { expect(page).to have_button("Destroy") }

      context "with active activity" do
        it("displays activity archival status") { expect(page).to have_text("Active") }
        it("has archive button") { expect(page).to have_button("Archive") }
      end

      context "with archived activity" do
        before do
          activity.archive!
          visit activities_path
        end

        it("displays activity archival status") { expect(page).to have_text("Archived") }
        it("has unarchive button") { expect(page).to have_button("Unarchive") }
      end
    end

    describe "show page" do
      before { visit activity_path(activity) }

      it("displays name") { expect(page).to have_text(activity.name) }
      it("displays description") { expect(page).to have_text(activity.description) }
      it("has edit link") { expect(page).to have_link(href: edit_activity_path(activity)) }
      it("has destroy button") { expect(page).to have_button("Destroy") }
      it("has back link") { expect(page).to have_link("Back") }

      context "with active activity" do
        it("displays archival sattus") { expect(page).to have_text("Active") }
        it("has archive button") { expect(page).to have_button("Archive") }
      end

      context "with archived activity" do
        before do
          activity.archive!
          visit activity_path(activity)
        end

        it("displays archival sattus") { expect(page).to have_text("Archived") }
        it("has unarchive button") { expect(page).to have_button("Unarchive") }
      end
    end

    scenario "user does not get archived activities on index" do
      archived_activity = create :activity, user: user, archived: true
      visit root_path
      expect(page).to have_text(activity.name)
      expect(page).to have_no_text(archived_activity.name)
    end

    scenario "user edits an activity" do
      click_link "Manage Activities"
      click_link "Edit", href: edit_activity_path(activity)
      fill_in "activity_name", with: "My Activity"
      click_button "Save"
      expect(activity.reload.name).to eq("My Activity")
    end

    scenario "user archives activity" do
      click_link "Manage Activities"
      click_button "Archive"
      expect(activity.reload.archived).to be(true)
    end

    scenario "user unarchives activity" do
      activity.archive!
      click_link "Manage Activities"
      click_button "Unarchive"
      expect(activity.reload.archived).to be(false)
    end
  end

  context "with JS" do
    context "with an activity" do
      let(:activity) { create :activity, user: user }

      before do
        # Capybara.current_driver = :selenium
        activity
        visit root_path
      end

      # after { Capybara.use_default_driver }

      scenario "user deletes an activity" do
        pending "Browser not supported in test env yet"

        find('div#trigger-user-options').click
        click_link "Manage Activities"
        accept_confirm { click_button "Destroy" }
        expect(Activity.where(id: activity.id).take).to be_nil
      end
    end
  end
end

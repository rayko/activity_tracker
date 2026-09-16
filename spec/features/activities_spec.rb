require "rails_helper"

RSpec.describe "Activities" do
  let(:user) { create :user }

  before { sign_in(user) }

  scenario "user creates new activity from root" do
    visit root_path
    click_link "New activity"
    fill_in "activity_name", with: "Task"
    fill_in "activity_description", with: "A custom task"
    click_button "Save"
    expect(user.activities.count).to eq(1)
  end

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

    scenario "user lists activities" do
      click_link "Manage Activities"
      expect(page).to have_text(activity.name)
      expect(page).to have_text(activity.description)
    end

    scenario "user edits an activity" do
      click_link "Manage Activities"
      click_link "Edit", href: edit_activity_path(activity)
      fill_in "activity_name", with: "My Activity"
      click_button "Save"
      expect(activity.reload.name).to eq("My Activity")
    end

    scenario "user registers activity hit" do
      click_button "+"
      expect(activity.reload.activity_hits.count).to eq(1)
    end

    scenario "user does not register activity hit twice" do
      click_button "+"
      click_button "+"
      expect(activity.reload.activity_hits.count).to eq(1)
    end

    scenario "user unregisters activity hit" do
      activity.activity_hits.create! date: DateTime.now
      click_button "-"
      expect(activity.reload.activity_hits.count).to eq(0)
    end

    scenario "user does not unregister activity hit done today" do
      activity.activity_hits.create! date: 1.day.ago
      click_button "-"
      expect(activity.reload.activity_hits.count).to eq(1)
    end

    scenario "user can register/unregister hit today" do
      visit root_path
      click_button "+"
      click_button "-"
      expect(activity.reload.activity_hits.count).to eq(0)
    end
  end

  context "with JS" do
    context "with an activity" do
      let(:activity) { create :activity, user: user }

      before do
        Capybara.current_driver = :selenium
        activity
        visit root_path
      end

      after { Capybara.use_default_driver }

      scenario "user deletes an activity" do
        find('div#trigger-user-options').click
        click_link "Manage Activities"
        accept_confirm { click_button "Destroy" }
        expect(Activity.where(id: activity.id).take).to be_nil
      end
    end
  end
end

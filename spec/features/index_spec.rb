require "rails_helper"

RSpec.describe "Index" do
  let(:user) { create :user }

  scenario "unauthenticated users is presented login form" do
    visit root_path
    expect(page).to have_text("You need to sign in or sign up before continuing")
    expect(page).to have_button("Log in")
  end

  context "with authenticated user" do
    let(:active_activity) { create :activity, user: user }
    let(:archived_activity) { create :activity, user: user, archived: true }

    before do
      sign_in(user)
      active_activity
      archived_activity
    end

    describe "root path" do
      before { visit root_path }

      it("shows active activity") { expect(page).to have_text(active_activity.name) }
      it("does not show archived activity") { expect(page).to have_no_text(archived_activity.name) }
      it("has hit register button") { expect(page).to have_button("+") }
      it("has hit unregister button") { expect(page).to have_button("-") }
      it("has create activity button") { expect(page).to have_link(href: new_activity_path) }
      it("has link back to root") { expect(page).to have_link(href: root_path) }
      it("has link to activities index") { expect(page).to have_link(href: activities_path) }
      it("has link to account info") { expect(page).to have_link(href: user_path) }
      it("has logout button") { expect(page).to have_button("Sign out") }
    end

    scenario "user new activity from root" do
      visit root_path
      click_link "New activity", href: new_activity_path
      fill_in "activity_name", with: "Task"
      fill_in "activity_description", with: "A custom task"
      expect { click_button("Save") }.to change(user.activities, :count).by(1)
      expect(page).to have_current_path(root_path)
      expect(page).to have_text("Task")
    end

    scenario "user registers activity hit" do
      visit root_path
      expect { click_button ("+") }.to change(active_activity.activity_hits, :count).by(1)
    end

    scenario "user does not register activity hit twice" do
      visit root_path
      click_button "+"
      expect { click_button ("+") }.to_not change(active_activity.activity_hits, :count)
    end

    scenario "user unregisters activity hit" do
      visit root_path
      active_activity.activity_hits.create! date: DateTime.now
      expect { click_button ("-") }.to change(active_activity.activity_hits, :count).by(-1)
    end

    scenario "user does not unregister activity hit done today" do
      visit root_path
      active_activity.activity_hits.create! date: 1.day.ago
      expect { click_button ("-") }.to_not change(active_activity.activity_hits, :count)
    end

    scenario "user can register/unregister hit today" do
      visit root_path
      click_button "+"
      click_button "-"
      expect(active_activity.reload.activity_hits.count).to eq(0)
    end
  end
end

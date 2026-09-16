require "rails_helper"

RSpec.describe "Login" do
  let(:user) { create :user, password: "123456" }

  before { user }

  scenario "existing user logins with email and password" do
    visit root_path
    fill_in "user_email", with: user.email
    fill_in "user_password", with: "123456"
    click_button "Log in"
    expect(page).to have_link("New activity")
  end

  scenario "existing user fails to login with wrong password" do
    visit root_path
    fill_in "user_email", with: user.email
    fill_in "user_password", with: "456789"
    click_button "Log in"
    expect(page).to have_text("Invalid email or password.")
    expect(page).to have_current_path(new_user_session_path)
  end

  scenario "missing user fails to login" do
    visit root_path
    fill_in "user_email", with: "bla@bla.com"
    fill_in "user_password", with: "123456"
    click_button "Log in"
    expect(page).to have_text("Invalid email or password.")
    expect(page).to have_current_path(new_user_session_path)
  end
end

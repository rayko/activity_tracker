require "rails_helper"

RSpec.describe "User" do
  let(:user) { create :user, password: "123456" }

  before { sign_in(user) }

  scenario "user views account" do
    visit root_path
    find('div#trigger-user-options').click
    click_link "Account"
    expect(page).to have_text(user.name)
    expect(page).to have_text(user.email)
  end

  scenario "user edits name" do
    visit root_path
    find('div#trigger-user-options').click
    click_link "Account"
    click_link "Edit", href: edit_user_path
    fill_in "user_name", with: "Lolcat"
    click_button "Save"
    expect(user.reload.name).to eq("Lolcat")
  end

  scenario "user edits password" do
    original = user.encrypted_password
    visit root_path
    find('div#trigger-user-options').click
    click_link "Account"
    click_link "Update Password", href: edit_user_password_path
    fill_in "user_current_password", with: "123456"
    fill_in "user_password", with: "456789"
    fill_in "user_password_confirmation", with: "456789"
    click_button "Save"
    expect(user.reload.encrypted_password).to_not eq(original)
  end

  scenario "user cannot update password with wrong current one" do
    original = user.encrypted_password
    visit root_path
    find('div#trigger-user-options').click
    click_link "Account"
    click_link "Update Password", href: edit_user_password_path
    fill_in "user_current_password", with: "789789"
    fill_in "user_password", with: "456789"
    fill_in "user_password_confirmation", with: "456789"
    click_button "Save"
    expect(user.reload.encrypted_password).to eq(original)
  end

  scenario "user cannot update password with wrong confirmation" do
    original = user.encrypted_password
    visit root_path
    find('div#trigger-user-options').click
    click_link "Account"
    click_link "Update Password", href: edit_user_password_path
    fill_in "user_current_password", with: "123456"
    fill_in "user_password", with: "456789"
    fill_in "user_password_confirmation", with: "789789"
    click_button "Save"
    expect(user.reload.encrypted_password).to eq(original)
  end
end

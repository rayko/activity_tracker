require 'rails_helper'

RSpec.describe 'user/edit_password' do
  let(:user) { create(:user) }

  before { assign(:user, user) }

  it "renders the edit form" do
    expect(render).to have_css("form[action='#{update_user_password_path}']")
  end

  it "renders input for current password" do
    expect(render).to have_field("user_current_password")
  end

  it "renders input for new password" do
    expect(render).to have_field("user_password")
  end

  it "renders input for new password confirmation" do
    expect(render).to have_field("user_password_confirmation")
  end
end

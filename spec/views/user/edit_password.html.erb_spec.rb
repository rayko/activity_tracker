require 'rails_helper'

RSpec.describe 'user/edit_password', type: :view do
  let(:user) { create(:user) }

  before do(:each)
    assign(:user, user)
  end

  it "renders the edit form" do
    expect(render).to have_selector("form[action='#{update_user_password_path}']")
  end

  it "renders input for current password" do
    expect(render).to have_selector("input[type=password][id=user_current_password]")
  end

  it "renders input for new password" do
    expect(render).to have_selector("input[type=password][id=user_password]")
  end

  it "renders input for new  password confirmation" do
    expect(render).to have_selector("input[type=password][id=user_password_confirmation]")
  end
end

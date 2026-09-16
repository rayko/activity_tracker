require 'rails_helper'

RSpec.describe 'user/edit', type: :view do
  let(:user) { create(:user) }

  before do(:each)
    assign(:user, user)
  end

  it "renders the edit form" do
    expect(render).to have_selector("form[action='#{update_user_path}']")
  end

  it "renders input for name" do
    expect(render).to have_selector("input[type=text][id=user_name]")
  end
end

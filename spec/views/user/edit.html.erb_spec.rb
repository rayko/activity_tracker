require 'rails_helper'

RSpec.describe 'user/edit' do
  let(:user) { create(:user) }

  before { assign(:user, user) }

  it "renders the edit form" do
    expect(render).to have_field("form[action='#{update_user_path}']")
  end

  it "renders input for name" do
    expect(render).to have_field("input[type=text][id=user_name]")
  end
end

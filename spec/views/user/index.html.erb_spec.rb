require 'rails_helper'

RSpec.describe 'user/index', type: :view do
  let(:user) { create(:user) }

  before do(:each)
    assign(:user, user)
  end

  it 'shows user name' do
    expect(render).to have_content(user.name)
  end

  it 'shows user email' do
    expect(render).to have_content(user.email)
  end

  it 'shows edit link' do
    expect(render).to have_link('Edit', href: edit_user_path)
  end

  it 'renders edit password link' do
    expect(render).to have_link('Update Password', href: edit_user_password_path)
  end
end

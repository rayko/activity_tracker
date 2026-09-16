require 'rails_helper'

RSpec.describe 'user/index' do
  let(:user) { create(:user) }

  before { assign(:user, user) }

  it 'shows user name' do
    expect(render).to have_text(user.name)
  end

  it 'shows user email' do
    expect(render).to have_text(user.email)
  end

  it 'shows edit link' do
    expect(render).to have_link('Edit', href: edit_user_path)
  end

  it 'renders edit password link' do
    expect(render).to have_link('Update Password', href: edit_user_password_path)
  end
end

require 'rails_helper'

RSpec.describe "devise/sessions/new" do
  before do
    # Don't complain about stubbing missing methods here
    # Not the best way but it works. Assuming this is always enabled
    RSpec::Mocks.configuration.verify_partial_doubles = false

    allow(view).to receive_messages(resource_name: :user, resource: User.new, devise_mapping: Devise.mappings[:user])

    # allow(view).to receive(:resource_name).and_return(:user)
    # allow(view).to receive(:resource).and_return(User.new)
    # allow(view).to receive(:devise_mapping).and_return(Devise.mappings[:user])
    render
  end

  after do
    RSpec::Mocks.configuration.verify_partial_doubles = true
  end

  it "renders the edit activity form" do
    expect(rendered).to have_css("form[action='#{user_session_path}']")
  end

  it "renders input for email" do
    expect(rendered).to have_field("user_email")
  end

  it "renders input for password" do
    expect(rendered).to have_field("user_password")
  end
end

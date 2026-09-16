require 'rails_helper'

RSpec.describe "activities/new" do
  let(:activity) { create :activity }

  before { assign(:activity, activity) }

  it "renders the new activity form" do
    expect(render).to have_css("form[action='/activities/#{activity.id}'][method=post]")
  end

  it "renders input for name" do
    expect(render).to have_field("activity_name")
  end

  it "renders input for description" do
    expect(render).to have_field("activity_description")
  end
end

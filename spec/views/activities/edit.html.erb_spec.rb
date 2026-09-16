require 'rails_helper'

RSpec.describe "activities/edit" do
  let(:activity) { create :activity }

  before { assign(:activity, activity) }

  it "renders the edit activity form" do
    expect(render).to have_field("form[action='/activities/#{activity.id}']")
  end

  it "renders input for name" do
    expect(render).to have_field("input[type=text][id=activity_name]")
  end

  it "renders input for description" do
    expect(render).to have_field("textarea[id=activity_description]")
  end
end

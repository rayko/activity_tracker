require 'rails_helper'

RSpec.describe "activities/edit", type: :view do
  let(:activity) { create :activity }

  before(:each) do
    assign(:activity, activity)
  end

  it "renders the edit activity form" do
    expect(render).to have_selector("form[action='/activities/#{activity.id}']")
  end

  it "renders input for name" do
    expect(render).to have_selector("input[type=text][id=activity_name]")
  end

  it "renders input for description" do
    expect(render).to have_selector("textarea[id=activity_description]")
  end
end

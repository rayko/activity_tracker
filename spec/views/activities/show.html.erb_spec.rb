require 'rails_helper'

RSpec.describe "activities/show", type: :view do
  let(:activity) { create :activity }

  before(:each) do
    assign(:activity, activity)
  end

  it "displays activity name" do
    expect(render).to match /#{activity.name}/
  end

  it 'displays activity description' do
    expect(render).to match /#{activity.description}/
  end

  it 'displays Edit button' do
    expect(render).to have_link("Edit", href: edit_activity_path(activity))
  end

  it 'displays Destroy button' do
    expect(render).to have_button("Destroy")
  end
end

require 'rails_helper'

RSpec.describe "activities/index" do
  let(:user) { create :user }
  let(:activities) do
    [
      create(:activity, user: user),
      create(:activity, user: user),
      create(:activity, user: user),
    ]
  end

  before { assign(:activities, activities) }

  it "displays activity IDs" do
    render
    activities.each do |activity|
      expect(rendered).to match /#{activity.id}/
    end
  end

  it "displays activity names" do
    render
    activities.each do |activity|
      expect(rendered).to match /#{activity.name}/
    end
  end

  it "displays activity edit links" do
    render
    activities.each do |activity|
      expect(rendered).to have_link("Edit", href: edit_activity_path(activity))
    end
  end

  it "displays activity destroy links" do
    render
    activities.each do |activity|
      expect(rendered).to have_button("Destroy")
    end
  end
end

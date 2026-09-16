require 'rails_helper'

RSpec.describe "activities/show", type: :view do
  before(:each) do
    assign(:activity, create(:activity))
  end

  it "renders attributes in <p>" do
    render
  end
end

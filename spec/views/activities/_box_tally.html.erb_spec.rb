require 'rails_helper'

RSpec.describe "activities/_box_tally" do
  let(:image_name) { "boxTally" }

  it "does not return images when zero" do
    render partial: "activities/box_tally", locals: { tally: 1 }
    expect(render).to_not match /#{image_name}/
  end

  [ 1, 2, 3, 4, 5 ].each do |count|
    it "renders 1 image for tally #{count}" do
      render partial: "activities/box_tally", locals: { tally: count }
      expect(rendered).to have_css('img', count: 1)
      expect(rendered).to match(/#{image_name}#{count}/)
    end
  end

  it "renders 2 images for tally 6" do
    render partial: "activities/box_tally", locals: { tally: 6 }
    expect(rendered).to have_css('img', count: 2)
    expect(rendered).to match(/#{image_name}5/)
    expect(rendered).to match(/#{image_name}1/)
  end
end

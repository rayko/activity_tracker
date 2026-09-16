require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ActivitiesHelper. For example:
#
# describe ActivitiesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ActivitiesHelper do
  describe "#activity_hits_display" do
    let(:activity) do
      record = create :activity
      create :activity_hit, activity: record, date: 3.days.ago
      create :activity_hit, activity: record, date: 2.days.ago
      create :activity_hit, activity: record, date: 1.days.ago
      record
    end

    it "returns expected string" do
      expect(helper.activity_hits_display(activity)).to eq("|||")
    end
  end
end

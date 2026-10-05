require "rails_helper"

RSpec.describe ActivityHitsController do
  describe "routing" do
    it "routes to #destroy" do
      expect(delete: "/activity_hits/1").to route_to("activity_hits#destroy", id: "1")
    end
  end
end

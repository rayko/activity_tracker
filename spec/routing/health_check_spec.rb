require "rails_helper"

RSpec.describe "HealthCheck", type: :routing do
  describe "routing" do
    it "routes to #rails/health#show" do
      expect(get: "/up").to route_to("rails/health#show")
    end
  end
end

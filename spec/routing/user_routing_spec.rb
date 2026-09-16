require "rails_helper"

RSpec.describe UserController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/user/index").to route_to("user#index")
    end

    it "routes to #edit" do
      expect(get: "/user/edit").to route_to("user#edit")
    end

    it "routes to #edit_password" do
      expect(get: "/user/edit_password").to route_to("user#edit_password")
    end

    it "routes to #update via PUT" do
      expect(put: "/user/update").to route_to("user#update")
    end

    it "routes to #update_password via PUT" do
      expect(put: "/user/update_password").to route_to("user#update_password")
    end
  end
end

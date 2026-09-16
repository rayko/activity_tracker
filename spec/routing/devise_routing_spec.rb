require "rails_helper"

RSpec.describe "UsersController" do
  describe "routing" do
    it "routes to devise/sessions#new" do
      expect(get: "/users/sign_in").to route_to("devise/sessions#new")
    end

    it "routes to #devise/sessions#create via POST" do
      expect(post: "/users/sign_in").to route_to("devise/sessions#create")
    end

    it "routes to #devise/sessions#destroy via DELETE" do
      expect(delete: "/users/sign_out").to route_to("devise/sessions#destroy")
    end
  end
end

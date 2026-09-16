require "rails_helper"

RSpec.describe "Application", type: :request do
  let(:user) { create :user, password: "123456" }

  RSpec.shared_examples "anon_user" do |verb|
    it "redirects to login path when not logged in" do
      send(verb, route)
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "GET /index" do
    let(:route) { root_path }
    include_examples "anon_user", :get

    context "for authenticated user" do
      before(:each) { sign_in(user) }

      context "with empty db" do
        it "returns 200 status" do
          get route
          expect(response).to be_successful
        end
      end

      context "with some records" do
        before do
          activity = create :activity, user: user
          create :activity, user: user
          create :activity_hit, activity: activity, date: 3.days.ago
          create :activity_hit, activity: activity, date: 2.days.ago
          create :activity_hit, activity: activity, date: 1.days.ago
          create :activity_hit, activity: activity, date: 1.month.ago
          create :activity_hit, activity: activity, date: 2.month.ago
        end

        it "returns 200 status" do
          get route
          expect(response).to be_successful
        end
      end
    end

  end
end

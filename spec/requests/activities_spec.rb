require 'rails_helper'

RSpec.describe "/activities" do
  let(:user) { create :user }
  let(:activity) { create :activity, user: user }

  before { activity }

  RSpec.shared_examples "anon_user" do |verb|
    it "redirects to login path when not logged in" do
      send(verb, route)
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "POST /register_hit" do
    let(:route) { register_hit_activity_path(activity) }

    it_behaves_like "anon_user", :post

    context "with authenticated user" do
      before { sign_in(user) }

      it "redirects to root" do
        post route
        expect(response).to redirect_to(root_path)
      end

      it "creates a hit record for activity" do
        expect { post route }.to change(activity.activity_hits, :count).by(1)
      end

      it "does not create more than 1 hit on the same day" do
        activity.activity_hits.create!(date: 1.hour.ago)
        expect { post route }.to_not change(activity.activity_hits, :count)
      end

      it "can create hit after 8 hours from last one" do
        activity.activity_hits.create!(date: 9.hours.ago)
        expect { post route }.to change(activity.activity_hits, :count).by(1)
      end
    end
  end

  describe "POST /unregister_hit" do
    let(:route) { unregister_hit_activity_path(activity) }

    it_behaves_like "anon_user", :post

    context "with authenticated user" do
      let(:hit) { activity.activity_hits.create!(date: DateTime.now) }

      before do
        sign_in(user)
        hit
      end

      it "redirects to root" do
        post route
        expect(response).to redirect_to(root_path)
      end

      it "removes a hit record for activity" do
        expect { post route }.to change(activity.activity_hits, :count).by(-1)
      end

      it "fails if no hits today" do
        post route
        expect { post route }.to_not change(activity.activity_hits, :count)
      end
    end
  end

  describe "GET /index" do
    let(:route) { activities_path }

    it_behaves_like "anon_user", :get

    context "with authenticated user" do
      before { sign_in(user) }

      it "returns 200" do
        get route
        expect(response).to be_successful
      end
    end
  end

  describe "GET /show" do
    let(:route) { activity_path(activity) }

    it_behaves_like "anon_user", :get

    context "with authenticated user" do
      before { sign_in(user) }

      it "renders a successful response" do
        get route
        expect(response).to be_successful
      end
    end
  end

  describe "GET /new" do
    let(:route) { new_activity_path }

    it_behaves_like "anon_user", :get

    context "with authenticated user" do
      before { sign_in(user) }

      it "renders a successful response" do
        get route
        expect(response).to be_successful
      end
    end
  end

  describe "GET /edit" do
    let(:route) { edit_activity_path(activity) }

    it_behaves_like "anon_user", :get

    context "with authenticated user" do
      before { sign_in(user) }

      it "renders a successful response" do
        get route
        expect(response).to be_successful
      end
    end
  end

  describe "POST /create" do
    let(:route) { activities_path }
    let(:form_data) { { activity: { name: "Test" } } }

    it_behaves_like "anon_user", :post

    context "with authenticated user" do
      before { sign_in(user) }

      it "creates an activity" do
        expect { post route, params: form_data }.to change(Activity, :count).by(1)
      end

      it "redirects to root" do
        post route, params: { activity: { name: "Test" } }
        expect(response).to redirect_to(root_path)
      end

      it "returns 422 if invalid" do
        form_data[:activity][:name] = nil
        post route, params: form_data
        expect(response).to have_http_status(422)
      end

      it "creates the activity on the current_user" do
        post route, params: { activity: { name: "Test" } }
        expect(Activity.last.user_id).to eq(user.id)
      end
    end
  end

  describe "PATCH /update" do
    let(:route) { activity_path(activity) }

    it_behaves_like "anon_user", :patch

    context "with authenticated user" do
      before { sign_in(user) }

      it "updates activity" do
        name = activity.name
        patch route, params: { activity: { name: "Test" } }
        expect(activity.reload.name).to_not eq(name)
      end

      it "redirects to activity show" do
        patch route, params: { activity: { name: "Test" } }
        expect(response).to redirect_to(activity_path(activity))
      end

      it "returns 422 if invalid" do
        patch route, params: { activity: { name: nil } }
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "DELETE /destroy" do
    let(:route) { activity_path(activity) }

    it_behaves_like "anon_user", :delete

    context "with authenticated user" do
      before { sign_in(user) }

      it "deletes activity" do
        expect { delete route }.to change(Activity, :count).by(-1)
      end

      it "redirects to root" do
        delete route
        expect(response).to redirect_to(root_path)
      end
    end
  end
end

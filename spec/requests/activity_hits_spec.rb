require 'rails_helper'

RSpec.describe "ActivityHits" do
  let(:user) { create :user }
  let(:activity) { create :activity, user: user }
  let(:hit) { create :activity_hit, activity: activity }

  describe "DELETE /destroy" do
    let(:route) { activity_hit_path(hit) }

    it_behaves_like "anon_user_request", :delete

    context "with authenticated user" do
      before { sign_in(user); hit }

      it "deletes hit" do
        expect { delete route }.to change(ActivityHit, :count).by(-1)
      end

      it "redirects to activity show" do
        delete route
        expect(response).to redirect_to(activity_path(activity))
      end
    end
  end
end

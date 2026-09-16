require "rails_helper"

RSpec.describe "Users" do
  let(:user) { create :user, password: "123456" }

  RSpec.shared_examples "anon_user" do |verb|
    it "redirects to login path when not logged in" do
      send(verb, route)
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "GET /index" do
    let(:route) { user_path }

    it_behaves_like "anon_user", :get

    context "with authenticated user" do
      before { sign_in(user) }

      it "returns 200 status" do
        get route
        expect(response.status).to have_http_status(200)
      end
    end
  end

  describe "GET /edit" do
    let(:route) { edit_user_path }

    it_behaves_like "anon_user", :get

    context "with authenticated user" do
      before { sign_in(user) }

      it "returns 200 status" do
        get route
        expect(response.status).to have_http_status(200)
      end
    end
  end

  describe "GET /edit_password" do
    let(:route) { edit_user_password_path }

    it_behaves_like "anon_user", :get

    context "with authenticated user" do
      before { sign_in(user) }

      it "returns 200 status" do
        get route
        expect(response.status).to have_http_status(200)
      end
    end
  end

  describe "PUT /update" do
    let(:route) { update_user_path }

    it_behaves_like "anon_user", :put

    context "with authenticated user" do
      before { sign_in(user) }

      it "redirects to user index" do
        put route, params: { user: { name: "Bob" } }
        expect(response).to redirect_to(user_path)
      end

      it "updates user" do
        name = user.name
        put route, params: { user: { name: "Bob" } }
        expect(user.reload.name).to_not eq(name)
      end

      it "returns 422 when invalid update" do
        put route, params: { user: { name: "X"*129 } }
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "PUT /update_password" do
    let(:route) { update_user_password_path }
    let(:form_data) do
      {
        user:
          {
            current_password: "123456",
            password: "456789",
            password_confirmation: "456789",
          },
      }
    end

    it_behaves_like "anon_user", :put

    context "with authenticated user" do
      before { sign_in(user) }

      it "redirects to user index" do
        put route, params: form_data
        expect(response).to redirect_to(user_path)
      end

      it "updates user" do
        pass = user.encrypted_password
        put route, params: form_data
        expect(user.reload.encrypted_password).to_not eq(pass)
      end

      it "returns 422 when invalid update" do
        form_data[:user][:password] = "987987987"
        put route, params: form_data
        expect(response).to have_http_status(422)
      end
    end
  end
end

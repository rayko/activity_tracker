require "rails_helper"

RSpec.describe "Users", type: :request do
  let(:user) { create :user, password: "123456" }

  RSpec.shared_examples "anon_user" do |verb|
    it "redirects to login path when not logged in" do
      send(verb, route)
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "GET /index" do
    let(:route) { user_path }
    include_examples "anon_user", :get

    context "for authenticated user" do
      before(:each) { sign_in(user) }

      it "returns 200 status" do
        get route
        expect(response.status).to eq(200)
      end

    end
  end

  describe "GET /edit" do
    let(:route) { edit_user_path }
    include_examples "anon_user", :get

    context "for authenticated user" do
      before(:each) { sign_in(user) }

      it "returns 200 status" do
        get route
        expect(response.status).to eq(200)
      end

    end
  end

  describe "GET /edit_password" do
    let(:route) { edit_user_password_path }
    include_examples "anon_user", :get

    context "for authenticated user" do
      before(:each) { sign_in(user) }

      it "returns 200 status" do
        get route
        expect(response.status).to eq(200)
      end

    end
  end

  describe "PUT /update" do
    let(:route) { update_user_path }
    include_examples "anon_user", :put

    context "for authenticated user" do
      before(:each) { sign_in(user) }

      it "redirects to user index" do
        put route, params: { user: { name: "Bob" } }
        expect(response).to redirect_to(user_path)
      end

      it "updates user" do
        name = user.name
        put route, params: { user: { name: "Bob" } }
        expect(user.reload.name).not_to eq(name)
      end

      it "returns 422 when invalid update" do
        put route, params: {user: { name: "X"*129 }}
        expect(response).to have_http_status(:unprocessable_content)
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
            password_confirmation: "456789"
          }
      }
    end
    include_examples "anon_user", :put

    context "for authenticated user" do
      before(:each) { sign_in(user) }

      it "redirects to user index" do
        put route, params: form_data
        expect(response).to redirect_to(user_path)
      end

      it "updates user" do
        pass = user.encrypted_password
        put route, params: form_data
        expect(user.reload.encrypted_password).not_to eq(pass)
      end

      it "returns 422 when invalid update" do
        form_data[:user][:password] = "987987987"
        put route, params: form_data
        expect(response).to have_http_status(:unprocessable_content)
      end

    end
  end

end

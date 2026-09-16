RSpec.shared_examples "anon_user_request" do |verb|
  it "redirects to login path when not logged in" do
    send(verb, route)
    expect(response).to redirect_to(new_user_session_path)
  end
end

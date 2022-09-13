require "rails_helper"

RSpec.describe "Posts", type: :request do
  describe "GET /posts" do
    it "works! (now write some real specs)" do
      user = User.new(
        name: "Test",
        email: "Test@gmail.com",
        password: "password",
      )
      user.save

      # p user

      post = Post.new(
        user_id: user.id,
        title: "Test",
        body: "Idk....",
        image: "",
      )
      post.save

      # p Post.all

      get "/posts.json"
      # p response
      posts = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(posts.length).to eq(2)
    end
  end

  describe "POST /posts" do
    it "should create new post" do
      user = User.new(
        name: "Test",
        email: "Test@gmail.com",
        password: "password",
      )
      user.save

      post "/sessions", params: {
                          email: "Test@gmail.com",
                          password: "password",
                        }
      auth = JSON.parse(response.body)
      jwt = auth["jwt"]

      post "/posts", params: {
                       user_id: user.id,
                       title: "Testing Post",
                       body: "Posting....",
                       image: "google",
                     },
                     headers: { "Authorization" => "Bearer #{jwt}" }
      post = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(post["title"]).to eq("Testing Post")
    end
  end
end

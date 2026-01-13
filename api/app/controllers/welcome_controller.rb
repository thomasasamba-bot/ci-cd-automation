class WelcomeController < ApplicationController
  def index
    render json: {
      message: "Welcome to the Rails API Demo!",
      description: "This is a containerized Rails API ready for CI/CD.",
      endpoints: {
        health_check: "/up",
        posts: "/posts"
      }
    }
  end
end

# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['GITHUB_CLIENT_ID', nil], ENV['GITHUB_CLIENT_SECRET', nil], scope: 'user'
end

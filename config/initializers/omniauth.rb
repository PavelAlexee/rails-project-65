Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, "Ov23liNAaNQqvQczlArK", "898e0a9ccaf16e0ba0737f3854a81263fc713b65", scope: "user"
end

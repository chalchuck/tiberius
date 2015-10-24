Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, '1e2dcfb5d8698bf690bd', 'c1e08975d9534fdba26394d91e83bde5234aeffc', scope: "repo, public_repo, delete_repo"
end

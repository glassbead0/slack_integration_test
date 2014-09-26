Rails.application.config.middleware.use OmniAuth::Builder do
  provider :slack, ENV['SLACK_ID'], ENV['SLACK_PW'] 
end

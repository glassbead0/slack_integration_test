Rails.application.config.middleware.use OmniAuth::Builder do
  provider :slack, '2538634938.2697763298', 'f80daae94301f2925d7d3b987f2ae960'
end

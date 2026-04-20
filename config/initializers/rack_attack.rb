# frozen_string_literal: true

# Throttle abusive/bot traffic at the Rack layer.
# Uses Rails cache (Solid Cache em produção) como store por padrão.
class Rack::Attack
  # Throttle geral por IP — barra scraping/scanning.
  throttle("req/ip", limit: 300, period: 5.minutes) do |req|
    req.ip unless req.path.start_with?("/up", "/assets")
  end

  # Throttle em tentativas de login por IP (duplica o rate_limit built-in, mas aplica antes do controller).
  throttle("logins/ip", limit: 5, period: 20.seconds) do |req|
    req.ip if req.path == "/session" && req.post?
  end
end

Rails.application.config.middleware.use Rack::Attack

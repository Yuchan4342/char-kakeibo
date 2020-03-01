# For 301 redirect.

if ENV['RACK_ENV'] == 'production'
  CharKakeibo::Application.config.middleware.insert_before(Rack::Runtime, Rack::Rewrite) do
    # 新 URL に redirect する.
    r301 %r{.*}, 'https://kakeibo.o-char.com$&', if: proc { |rack_env|
      # rack_env['SERVER_NAME'] != 'kakeibo.o-char.com'
      rack_env['SERVER_NAME'] == 'char-kakeibo.herokuapp.com'
    }
  end
end

if Rails.env.production?
  Rails.application.configure do
    config.middleware.use(Rack::Tracker) do
      handler :google_tag_manager, { container: 'GTM-PD6H7RV', turbolinks: true }
    end
  end
end
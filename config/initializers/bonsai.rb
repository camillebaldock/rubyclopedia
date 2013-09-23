ENV['ELASTICSEARCH_URL'] = ENV['BONSAI_URL']

# Optional, but recommended: use a single index per application per environment.
# Caveat: This convention not be entirely supported throughout Tire's API.
app_name = Rails.application.class.parent_name.underscore.dasherize
app_env = Rails.env
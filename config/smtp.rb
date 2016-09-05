SMTP_SETTINGS = {
  address: ENV.fetch('SMTP_ADDRESS'),
  port: ENV.fetch('SMTP_PORT'),
  domain: ENV.fetch('SMTP_DOMAIN'),
  authentication: :plain,
  enable_starttls_auto: true,
  user_name: ENV.fetch('SMTP_USERNAME'),
  password: ENV.fetch('SMTP_PASSWORD')
}.freeze

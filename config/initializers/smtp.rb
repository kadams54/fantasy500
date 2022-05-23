ActionMailer::Base.smtp_settings = {
  address: ENV["SMTP_HOST"],
  authentication: :plain,
  domain: ENV["HOST"],
  password: ENV["SMTP_PASSWORD"],
  port: ENV["SMTP_PORT"],
  user_name: ENV["SMTP_USERNAME"],
}

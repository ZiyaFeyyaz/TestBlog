class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('SMTP_USERNAME')
  default to: ENV.fetch('SMTP_USERNAME')

  layout 'mailer'
end

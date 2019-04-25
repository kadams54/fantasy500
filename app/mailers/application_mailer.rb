class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@fantasy500.herokuapp.com"
  layout "mailer"
end

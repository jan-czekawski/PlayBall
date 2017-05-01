class ApplicationMailer < ActionMailer::Base
  default from: "do-not-reply@at.com"
  layout "mailer"
end

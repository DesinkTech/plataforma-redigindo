# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# ActionMailer config

ActionMailer::Base.smtp_settings = {
    :user_name => Rails.application.credentials.dig(:ses, :user_name),
    :password => Rails.application.credentials.dig(:ses, :password),
    :port => 587,
    :address => "email-smtp.sa-east-1.amazonaws.com",
    :domain => "redigindo.com.br",
    :authentication => :login,
    :enable_starttls_auto => true
}

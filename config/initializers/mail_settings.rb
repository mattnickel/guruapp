# ActionMailer::Base.smtp_settings = {
#   domain: 'thinkbig-gofar.com',
#   address:        "smtp.sendgrid.net",
#   port:            587,
#   authentication: :plain,
#   user_name:      'apikey',
#   password:       ENV['SENDGRID_API_KEY']
# }

# TEST_ENVS = %w(test)
# FILESYSTEM_ENVS = TEST_ENVS + %w(development)

# # ===========  DELIVERY METHOD SETTING
# delivery_method = case Rails.env.to_sym
#                     when :production, :staging, :experimental
#                      :sendmail
#                     when :test
#                      :test
#                     else
#                      :smtp
#                   end

# ActionMailer::Base.delivery_method = delivery_method

# # ===========  SMTP SETTINGS
# ENVS_TO_USE_GMAIL_CONFIG = %w(development test)

# gmail_config = {
#   address:              'smtp.gmail.com',
#   port:                 587,
#   domain:               'gmail.com',
#   user_name:            ENV['MAIL_USER_NAME'],
#   password:             ENV['MAIL_PASSWORD'],
#   authentication:       :plain,
#   enable_starttls_auto: true
# }

# if :smtp == delivery_method
#   use_gmail_config = ENVS_TO_USE_GMAIL_CONFIG.include?(Rails.env)

#   smtp_settings = ( use_gmail_config ? gmail_config : {} )
#   ActionMailer::Base.smtp_settings = smtp_settings
# end

# # =========== DEFAULT URL OPTIONS

# default_url_options_settings = Settings.default_url_options
# host = default_url_options_settings.host
# port = default_url_options_settings.port
# protocol = default_url_options_settings.protocol

# default_url_options = {}
# default_url_options[:host] = host if host.present?
# default_url_options[:port] = port if port.present?
# default_url_options[:protocol] = protocol if protocol.present?

# ActionMailer::Base.default_url_options = default_url_options
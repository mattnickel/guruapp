require 'sendgrid-ruby'
include SendGrid

def hello_world
  		from = Email.new(email: 'test@example.com')
  		subject = 'Hello World from the Twilio SendGrid Ruby Library'
  		to = Email.new(email: 'mattnickel05@gmail.com')
  		content = Content.new(type: 'text/plain', value: 'some text here')
  		mail = SendGrid::Mail.new(from, subject, to, content)
  # puts JSON.pretty_generate(mail.to_json)
  		puts mail.to_json

  		sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
  		response = sg.client.mail._('send').post(request_body: mail.to_json)
  		puts response.status_code
  		puts response.body
  		puts response.headers
	end
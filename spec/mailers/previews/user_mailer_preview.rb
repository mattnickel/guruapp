# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  def weekly_report
      # subject ="Weekly Report for #{Date.today-1.week} to #{Date.today}"
      # message = "this a test"
      # UserMailer.report_message(subject, message).deliver
 
  end
end

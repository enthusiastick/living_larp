class Contact < MailForm::Base
  attribute :first_name, validate: true
  attribute :last_name, validate: true
  attribute :subject, validate: true
  attribute :email, validate: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message

  def headers
    {
      :subject => %("#{subject}"),
      :to => "contact@example.com",
      :from => %("#{first_name} #{last_name}" <#{email}>)
    }
  end
end

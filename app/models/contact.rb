class Contact < MailForm::Base
  attribute :name, validate: true
  attribute :email, validate: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message

  def headers
    {
      :subject => "Living LARP Contact Form",
      :to => "contact@example.com",
      :from => %("#{name}" <#{email}>)
    }
  end
end

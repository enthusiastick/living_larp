class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request
    if @contact.deliver
      flash.now[:error] = nil
      flash.now[:notice] = 'Thank you for your feedback.'
      render :new
    else
      flash.now[:error] = 'Unable to send message. Please retry.'
      render :new
    end
  end
end

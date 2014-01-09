class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request
    if @contact.deliver
      flash['alert-box alert'] = nil
      flash['alert-box'] = 'Thank you for your feedback.'
      redirect_to '/contact_us'
    else
      flash.now['alert-box alert'] = 'Unable to send message. Please retry.'
      render :new
    end
  end
end

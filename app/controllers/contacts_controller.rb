class ContactsController < ApplicationController


  def index
   @contact = Contact.all
  end

  def create 
  	@contact = Contact.create(email: params[:email], message: params[:message],  subject: params[:subject],  name: params[:name])
  	if @contact.save
  		
  		root_path
  	end
  end

  def destroy
     @contact = Contact.find(params[:id])
      if @contact.destroy
        redirect_to contacts_path
      end
  end

end

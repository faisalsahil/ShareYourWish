class SubscribersController < ApplicationController
  before_filter :redirect_unless_admin, :except => [:create]

  def index
    @subscribers = Subscriber.all
    @subscriber = Subscriber.new

    respond_to do |format|
      format.html
    end
  end

  def create
    @subscriber = Subscriber.new(params[:subscriber])

    respond_to do |format|
      if @subscriber.save
        flash[:notice] = 'Thanks for subscribing!'
        format.html { redirect_to root_path, notice: 'Message sent successfully' }
        format.js 
      else
        format.html { redirect_to :back, notice: 'Error, post was not successful' }
        format.js
      end
    end
  end

def edit
     @subscriber = Subscriber.find(params[:id])
end

def update
   @subscriber = Subscriber.find(params[:id])
   
   respond_to do |format|
     if @subscriber.update_attributes(params[:subscriber])
       flash[:notice] = 'Updated Successfully'
       format.js 
     else
       format.js
     end
  end
  
end




  def destroy
    @subscriber = Subscriber.find(params[:id])
    @subscriber.destroy

    respond_to do |format|
      format.html { redirect_to(subscribers_url) }
      format.js
    end
  end
end

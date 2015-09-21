require "digest" # for SHA2
class UsersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  # before_filter :redirect_unless_admin, :except => [:destroy]
   
  def index
    @users = User.paginate(:per_page => 9, :page => params[:page], :order => 'created_at DESC')
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
   if @user.save
     flash[:notice] = "Welcome to Share Your Wish!"
     redirect_to root_url
   else
     render :action => :new
   end

  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to users_url, :notice => "Account successfully updated" }
        format.json { render json: @user }
      else
        format.html { render :action => :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "Successfully removed account"
    redirect_to root_url
  end
end

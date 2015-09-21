class CartsController < ApplicationController
  before_filter :authenticate_user!
  caches_action :show
  
  def show
    @cart = Cart.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cart }
    end
  end

  def create
    @cart = Cart.new(params[:cart])
    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: 'cart was successfully created.' }
        format.json { render json: @cart, status: :created }
      else
        format.html { render action: "new" }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @cart = Cart.find_by_id(params[:id])

    respond_to do |format|
      if @cart.update_attributes(params[:cart])
        format.html { redirect_to @cart, notice: 'cart was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @cart = current_cart # Cart.find(params[:id]) - TO DO: for an Admin, need ability to kill specific cart, not just current to user
    @cart.destroy
    session[:cart_id] = nil

    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end    
  end
 
end

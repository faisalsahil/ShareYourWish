class LineItemsController < ApplicationController
   before_filter :authenticate_user!
   def index
      if params[:cart_id]
         @line_items = LineItem.find_by_cart_id(params[:cart_id])
      elsif params[:order_id]
         @line_items = LineItem.find_by_order_id(params[:order_id])
      elsif params[:user_id]
         @line_items = LineItem.find_by_user_id(params[:user_id])
      else
         @line_items = LineItem.all
      end

     respond_to do |format|
       format.html # index.html.erb
       format.json { render json: @line_items }
     end
   end

   def show
     @line_item = LineItem.find(params[:id])

     respond_to do |format|
       format.html # show.html.erb
       format.json { render json: @line_item }
     end
   end

   def new
     @line_item = LineItem.new

     respond_to do |format|
       format.html # new.html.erb
       format.json { render json: @line_item }
     end
   end

   def edit
     @line_item = LineItem.find(params[:id])
   end

  # POST /line_items.json
   def create
    	@cart = current_cart 
    	# For now, allow duplicates in cart. 
      item = Item.find(params[:item_id])
      if item.is_package_proxy?
         @cart.add_package_bundle_items item
      end
      @line_item = @cart.line_items.build(item: item, :cost=>item.cost)
      @cart.reload
      respond_to do |format|
         if @line_item.save
            format.js
            format.json { render json: @line_item,
            status: :created, location: @line_item }
         else
            format.js
            format.json { render json: @line_item.errors,
            status: :unprocessable_entity }
         end
      end
   end
   
   
   # PUT /line_items/1.json
   def update

    @cart = current_cart
     @line_item = LineItem.find(params[:id])

     respond_to do |format|
       if @line_item.update_attributes(params[:line_item])
         format.html { redirect_to @line_item, notice: 'Item was updated' } 
         format.js
         format.json { head :no_content }
       else
         format.html { render action: "edit" } 
         format.js
         format.json { render json: @line_item.errors, status: :unprocessable_entity }
       end
     end
   end


   def destroy
    @cart = current_cart
     @line_item = LineItem.find(params[:id]) 
     @line_item.destroy 

     respond_to do |format|
       format.html { redirect_to root_url } 
       format.js
       format.json { head :no_content }
     end
   end

   
   
end
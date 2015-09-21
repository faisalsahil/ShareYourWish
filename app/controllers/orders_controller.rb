class OrdersController < InheritedResources::Base
   before_filter :authenticate_user!
  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(params[:order])
    @cart = current_cart
    @order.transmit_line_items_from_cart(@cart) if @cart

    respond_to do |format|
      if @order.save
        format.html { redirect_to event_dashboard_path(@order.event), notice: "Your payment was successfully processed - thank you." }
        format.json { render json: @order, status: :created, location: @order }
      else
        format.html { redirect_to new_event_path(:user_id => current_user.id, :anchor => @last_tab), status: 307, alert: "Sorry, something went wrong: #{@order.errors.full_messages.join(',')} #{@order.payment.errors.full_messages.join(',')}" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end
end

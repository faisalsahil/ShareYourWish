# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  orders.initialize()

orders =
  initialize: ->
    @handleNewOrderForm()

  new_order_form: ->
    (jQuery "form#new_order")
  address_state_select: ->
    (jQuery "form#new_order #order_shipping_address_attributes_state_id")
  order_tax_total_cost: ->
    (jQuery "form#new_order #order_tax_total_cost")
  order_shipping_total_cost: ->
    (jQuery "form#new_order #order_shipping_total_cost")
  order_subtotal: ->
    (jQuery "form#new_order #order_subtotal")
  order_total_cost: ->
    (jQuery "form#new_order #order_total_cost")
  order_payment_attributes_amount: ->
    (jQuery "form#new_order #order_payment_attributes_amount")
  tax_total_cost: ->
    (jQuery ".form #tax_total_cost")
  subtotal: ->
    (jQuery ".form #subtotal")
  total_cost: ->
    (jQuery ".form #total_cost")
  order_form_container: ->
    (jQuery "#order_form_container")
  free_package_message: ->
    (jQuery "#free_package_message")
  checkout_button: ->
    (jQuery "#tabs-6 input.checkout")
  publish_button: ->
    (jQuery "#tabs-6 input.publish")
  checkout_confirm_button: ->
    (jQuery "#tabs-6 input.checkout_confirm")
  edit_order_button: ->
    (jQuery "#tabs-6 input.edit_order")
  cancel_event_button: ->
    (jQuery "#tabs-6 input.cancel_event_button")
  checkout_confirm_container: ->
    (jQuery '#checkout_confirm_container')

  handleNewOrderForm: ->
    @new_order_form().on "submit", ->
      if jQuery(@).valid()
        true
      else  
        false
    
    @address_state_select().on "change", ->
      orders.update_order_tax_total_cost()
      orders.recalculate_total_cost()
  clear_tax_total_and_order_shipping_total_cost: ->
    if parseFloat(@order_subtotal().val()) == 0.0
      @clear_order_tax_total_cost()
      @clear_shipping_total_cost()
  recalculate_total_cost: ->
    @clear_tax_total_and_order_shipping_total_cost()
    value = parseFloat(orders.order_tax_total_cost().val()) +
      parseFloat(orders.order_shipping_total_cost().val()) +
      parseFloat(orders.order_subtotal().val())
    orders.update_total_cost(value.toFixed(2))
  update_subtotal: (value) ->
    orders.order_subtotal().val(value.toFixed(2))
    orders.subtotal().html('$'+value.toFixed(2))
    orders.update_order_tax_total_cost()
  update_tax_total_cost: (value) ->
    orders.order_tax_total_cost().val(value)
    orders.tax_total_cost().html('$'+value)
  update_total_cost: (value) ->
    orders.order_total_cost().val(value)
    orders.total_cost().html('$'+value)
    orders.order_payment_attributes_amount().val(value)
  show_hide_checkout_confirm_container : -> 
    if orders.order_total_cost().val() > 0
      @show_checkout_confirm_container()
    else
      @hide_checkout_confirm_container()
  update_order_tax_total_cost: (persents = 7.375) ->
    state_id = orders.address_state_select().val();
    state_name = orders.address_state_select().find("option[value='#{state_id}']").text();
    if orders.isNewYork state_name
      tax_total_cost_value = parseFloat(orders.order_subtotal().val()*0.01*persents).toFixed(2)
      orders.update_tax_total_cost(tax_total_cost_value)
    else
      orders.clear_order_tax_total_cost()
  clear_order_tax_total_cost: -> 
    @update_tax_total_cost('0.00')
  clear_shipping_total_cost: ->
    @order_shipping_total_cost().val(0.00)
  isNewYork: (name) ->
    name == 'New York'
  show_order_form: -> 
    orders.order_form_container().show()
    orders.free_package_message().hide()
    orders.checkout_button().show()
    orders.publish_button().hide()
  hide_order_form: -> 
    orders.order_form_container().hide()
    orders.free_package_message().show()
    orders.checkout_button().hide()
    orders.publish_button().show()
  show_checkout_confirm_container: ->
    @checkout_confirm_container().show()
    @order_form_container().hide()
    @free_package_message().hide()
    @checkout_confirm_button().hide()
    @edit_order_button().hide()
    @checkout_button().hide()
    @cancel_event_button().show()
    @publish_button().show()
  hide_checkout_confirm_container: -> 
    @checkout_confirm_container().hide()
    @free_package_message().show()
    @order_form_container().hide()
    @checkout_confirm_button().hide()
    @edit_order_button().hide()
    @checkout_button().hide()
    @cancel_event_button().hide()
    @publish_button().show()
  show_free_package_message: ->
    @free_package_message().show()
    @publish_button().show()
  hide_free_package_message: ->
    @free_package_message().hide()
    @publish_button().hide()
    
this.orders = orders

module ApplicationHelper
  # Creates a link to the session[:return_to] uri or to the given block if there is no stored return point
  # Does not wipe :return_to_uri after it's been used.
  def link_back(text, *params)
    session[:return_to_uri] ? link_to(text, session[:return_to_uri]) : link_to(text, *params)
  end

  def production?
    @is_production ||= (ENV['RAILS_ENV']=='production')
  end

  def short(text, length = 200)
    text.html_safe.gsub(/<\/?[^>]*>|[^[[:alnum:]]\s\.:,\-]/, '')[0..length]
  end

  def nl2br string
    string.gsub(/\n/, '<br />').html_safe
  end

  def current_event
    if user_signed_in?
      Event.users_current_event(current_user)
    else
      nil
    end
  end
  
  def link_to_unless_current_action(name, options = {}, html_options = {}, &block)
    link_to_unless_current(name, options, html_options, block)
  end

  def first_word(t)
    t.first_word
  end

  def debug_enabled?
    session[:debug]=='opensesame'
  end

  def clean_with_new_lines string
    simple_format(string, {}, :sanitize => true)
  end
  
  def custom_sanitize string, options = {}
    sanitize string, :tags => %w(table tr th td tbody thead label div b strong img p ul li a address span sup sub em hr h1 h2 h3 ), :attributes => %w(id class style src alt title href)
  end

  def after_sign_out_path_for(resource_or_scope)
    root_url(:protocol => 'http')
  end

  # Braintree
  class BraintreeFormBuilder < ActionView::Helpers::FormBuilder
    include ActionView::Helpers::AssetTagHelper
    include ActionView::Helpers::TagHelper
    def initialize(object_name, object, template, options, proc)
      super
      @braintree_params = @options[:params]
      @braintree_errors = @options[:errors]
    end

    def fields_for(record_name, *args, &block)
      options = args.extract_options!
      options[:builder] = BraintreeFormBuilder
      options[:params] = @braintree_params && @braintree_params[record_name]
      options[:errors] = @braintree_errors && @braintree_errors.for(record_name)
      new_args = args + [options]
      super record_name, *new_args, &block
    end

    def text_field(method, options = {})
      has_errors = @braintree_errors && @braintree_errors.on(method).present?
      field = super(method, options.merge(:value => determine_value(method)))
      result = content_tag("div", field, :class => has_errors ? "fieldWithErrors" : "")
      result.safe_concat validation_errors(method)
      result
    end

    protected

    def determine_value(method)
      if @braintree_params
      @braintree_params[method]
      else
        nil
      end
    end

    def validation_errors(method)
      if @braintree_errors && @braintree_errors.on(method).present?
        @braintree_errors.on(method).map do |error|
          content_tag("div", ERB::Util.h(error.message), {:style => "color: red;"})
        end.join
      else
        ""
      end
    end
  end
  
  def asset_images_file_path filename
    File.join(Rails.root, 'app','assets','images', filename)
  end
end

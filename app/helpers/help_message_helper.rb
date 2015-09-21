module HelpMessageHelper
  def help_text_caption code
    help_message = HelpMessage.find_by_code code
    return '' unless help_message.is_a?(HelpMessage)
    %{<div class="help_message_container">
        <sup class="help_message_question"><a class="help_message_show_link" href="javascript:void(0)"><small>?</small></a></sup>
        <div class="hidden help_message_text">
          #{link_to image_tag('modal_close.png'), 'javascript:void(0);', :class => :close_button, :title => 'Close'}
          #{message_sanitize(help_message.text)}
        </div>
      </div>}.html_safe
  end
  
  def help_ajax_text_caption code
    %{<div class="help_message_container">
      <sup class="help_message_question"><a class="help_message_ajax_show_link" href="javascript:void(0)" data-code="#{code}"><small>?</small></a></sup>
      <div class="hidden help_message_text">
        #{link_to image_tag('modal_close.png'), 'javascript:void(0);', :class => :close_button, :title => 'Close'}
        <div class="help_message_target"></div>
      </div>
    </div>}.html_safe
  end
  
  def message_sanitize string, options = {}
    sanitize string, {:tags => %w(b ul li br a p), :attributes => %w(class style title href)}
  end
end

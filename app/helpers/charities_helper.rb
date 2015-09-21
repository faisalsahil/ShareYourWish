module CharitiesHelper
  def short_description (charity, length = 200, style_class = :charity_details)
    if charity.description.length > length
      charity.description.gsub(/<\/?[^>]*>|[^[[:alnum:]]\s\.:,\-]/, '')[0..length].html_safe << sprintf(" ...(%s)", link_to('more', charity, :class => style_class, :charity_id => charity.id)).html_safe 
    else
      charity.description
    end
  end
  def website charity
    charity.website_url.present? ? link_to(charity.website_url, charity.website_url) : '(not provided)'
  end
  
  # Trim description smaller if charity title is likely to take up two lines
  def two_lines_description charity, style_class = :charity_details
    charity.name.length < 24 ? desc_chars = 90 : desc_chars = 72
    short_description(charity, desc_chars, style_class)
  end
  
  def carusel_external_control count
    return '' unless count > 0
    output = %{<div class="externalControl"><div><button class="prev" type="button" tabindex="258"><<</button>}
    if count <= 42
      $i = 0; $b = 1;
      while $i < count do
        output += %{<button class="#{$b}" type="button" tabindex="258">#{$b}</button>}
        $i +=6; $b += 1;
      end
    else
      $i = 0; $b = 1;
      while $i < 18 do
        output += %{<button class="#{$b}" type="button" tabindex="258">#{$b}</button>}
        $i +=6; $b += 1;
      end
      output += '...'
      $i = count-18; $b = count/6-1;
      while $i < count do
        output += %{<button class="#{$b}" type="button" tabindex="258">#{$b}</button>}
        $i +=6; $b += 1;
      end
    end
    output += %{<button class="next" type="button" tabindex="258">>></button></div></div>}
    output.html_safe
  end
end

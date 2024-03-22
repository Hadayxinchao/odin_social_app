module ApplicationHelper
  def field_is_blank?(field)
    if field.nil?
      true
    else
      [nil, ''].include?(field.strip)
    end
  end
end

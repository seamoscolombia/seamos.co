module ApplicationHelper
  def meta_tag(tag, text)
    session[:"meta_#{tag}"] = text
  end

  def yield_meta_tag(tag, default_text='')
    session[:"meta_#{tag}"] ? session[:"meta_#{tag}"] : default_text
  end
end

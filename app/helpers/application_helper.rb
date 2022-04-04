# frozen_string_literal: true
module ApplicationHelper
  def select_format(selected)
    select_tag \
      :format,
      options_for_select(StoryKey::FORMATS.map { |f| [f, f] }, selected)
  end
end

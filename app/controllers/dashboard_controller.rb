# frozen_string_literal: true
class DashboardController < ApplicationController
  before_action :assign_defaults

  def index
    @split_key = key.chars.each_slice(50).map(&:join).join('<br>')
    @humanized = webify(story.humanized)
    @tokenized = story.tokenized
  rescue StoryKey::KeyTooLarge
    @error = key_too_large
  rescue StoryKey::InvalidFormat
    @error = "Invalid input for #{params[:format]}"
  end

  private

  def key
    params[:key].presence || StoryKey::Generator.call(bitsize:, format:)
  end

  def story
    @story ||= StoryKey::Encoder.call(key:, bitsize:, format:)
  end

  def bitsize
    @bitsize ||= params[:bitsize].to_i
  end

  def format
    @format ||= params[:format]
  end

  def webify(str)
    str.gsub(/\e\[(\d+)m([^\e]+)\e\[0m/, '<span class="color-\1">\2</span>')
       .gsub("\n", '<br>')
  end

  def key_too_large
    "Key too large (max #{StoryKey::MAX_BITSIZE})"
  end

  def assign_defaults
    @max_bitsize = StoryKey::MAX_BITSIZE
    params[:bitsize] ||= StoryKey::DEFAULT_BITSIZE
    params[:format] ||= StoryKey::FORMATS.first
  end
end

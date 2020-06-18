require 'tag_helper'

module AutoHtml
  # Facebook video filter
  class Facebook
    include TagHelper

    def initialize(width: 'auto', allow_fullscreen: true)
      @width = width
      @allow_fullscreen = allow_fullscreen
    end

    def call(text)
      text.gsub(fb_pattern) do
        video_url = "https://www.#{Regexp.last_match(2)}"
        tag(:div, class: 'video facebook') do
          tag(:div, { class: 'fb-video' }.merge(video_attributes(video_url: video_url))) { '' }
        end
      end
    end

    private

    def fb_pattern
      %r{(?<!href=["'])https://([A-Za-z]+.)?(facebook.com/[A-Za-z0-9._%-]*/videos/[0-9]+)/?((\?|#)[^\s<]+)?}
    end

    def video_attributes(video_url:)
      { 'data-href': video_url,
        'data-width': @width,
        'data-show-text': false,
        'data-allowfullscreen': @allow_fullscreen }
    end

  end
end
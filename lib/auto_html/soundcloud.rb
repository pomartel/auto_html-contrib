require 'tag_helper'

module AutoHtml
  class Soundcloud
    include TagHelper

    def initialize(width: '100%', height: 166, lazy: false)
      @width = width
      @height = height
      @lazy = lazy
    end

    def call(text)
      text.gsub(%r{(?<!href=["'])https?://(www.)?soundcloud\.com/([A-Za-z0-9._%-/]*)((\?|#)[^\s<]+)?}) do |match|
        path = Regexp.last_match(2)
        new_uri = "https://soundcloud.com/#{path}"
        tag = tag(:iframe, iframe_attributes(new_uri)) { '' }
        puts tag
        tag
      end
    end

    private

    def src_url(new_uri)
      "https://w.soundcloud.com/player/?url=#{new_uri}&hide_related=true&show_comments=false&show_user=false&show_reposts=false&show_teaser=false&visual=true"
    end

    def iframe_attributes(new_uri)
      src = src_url(new_uri)

      {}.tap do |attrs|
        attrs[:width] = @width
        attrs[:heigth] = @height
        attrs[:scrolling] = 'no'
        attrs[:frameborder] = 'no'
        if @lazy
          attrs['data-src'] = src
          attrs[:class] = 'lazyload'
        else
          attrs[:src] = src
        end
      end
    end

  end
end
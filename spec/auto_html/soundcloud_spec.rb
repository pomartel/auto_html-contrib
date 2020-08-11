require 'spec_helper'

RSpec.describe AutoHtml::Soundcloud do
  it 'transform soundcloud url' do
    result = subject.call('https://soundcloud.com/liluzivert/future-lil-uzi-vert-patek')
    expect(result).to eq '<iframe width="100%" heigth="166" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https://soundcloud.com/liluzivert/future-lil-uzi-vert-patek&hide_related=true&show_comments=false&show_user=false&show_reposts=false&show_teaser=false&visual=true"></iframe>'
  end
end

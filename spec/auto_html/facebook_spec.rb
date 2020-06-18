require 'spec_helper'

RSpec.describe AutoHtml::Facebook do
  it 'transform facebook url' do
    result = subject.call('https://www.facebook.com/TEDEducation/videos/271056024103664')
    expect(result).to eq '<div class="video facebook"><div class="fb-video" data-href="https://www.facebook.com/TEDEducation/videos/271056024103664" data-width="auto" data-show-text="false" data-allowfullscreen="true"></div></div>'
  end

  it 'transform facebook url with params' do
    result = subject.call('https://facebook.com/simple.polls/videos/1082630825454031/?pg=embed&sec=')
    expect(result).to eq '<div class="video facebook"><div class="fb-video" data-href="https://www.facebook.com/simple.polls/videos/1082630825454031" data-width="auto" data-show-text="false" data-allowfullscreen="true"></div></div>'
  end

  it 'transform facebook url with anchor' do
    result = subject.call('https://facebook.com/simple.polls/videos/1082630825454031/#skirt')
    expect(result).to eq '<div class="video facebook"><div class="fb-video" data-href="https://www.facebook.com/simple.polls/videos/1082630825454031" data-width="auto" data-show-text="false" data-allowfullscreen="true"></div></div>'
  end

  it 'transform facebook url wth options' do
    filter = described_class.new(width: 300, allow_fullscreen: false)
    result = filter.call('https://www.facebook.com/144026786272917/videos/233905737961500')
    expect(result).to eq '<div class="video facebook"><div class="fb-video" data-href="https://www.facebook.com/144026786272917/videos/233905737961500" data-width="300" data-show-text="false" data-allowfullscreen="false"></div></div>'
  end

  it 'does not transform facebook url inside an anchor tag with double quotes' do
    result = subject.call('<a href="https://www.facebook.com/144026786272917/videos/233905737961500">facebook</a>')
    expect(result).to eq '<a href="https://www.facebook.com/144026786272917/videos/233905737961500">facebook</a>'
  end

  it 'does not transform facebook url inside an anchor tag with single quotes' do
    result = subject.call("<a href='https://www.facebook.com/144026786272917/videos/233905737961500'>facebook</a>")
    expect(result).to eq "<a href='https://www.facebook.com/144026786272917/videos/233905737961500'>facebook</a>"
  end

  it 'does transform facebook url inside an anchor tag' do
    result = subject.call('<a href="https://www.facebook.com/144026786272917/videos/233905737961500">https://www.facebook.com/144026786272917/videos/233905737961500</a>')
    expect(result).to eq '<a href="https://www.facebook.com/144026786272917/videos/233905737961500"><div class="video facebook"><div class="fb-video" data-href="https://www.facebook.com/144026786272917/videos/233905737961500" data-width="auto" data-show-text="false" data-allowfullscreen="true"></div></div></a>'
  end
end

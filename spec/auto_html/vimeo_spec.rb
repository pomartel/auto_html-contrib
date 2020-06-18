require 'spec_helper'

RSpec.describe AutoHtml::Vimeo do
  it 'transform vimeo url' do
    result = subject.call('https://www.vimeo.com/3300155')
    expect(result).to eq '<div class="video vimeo"><div class="responsive-embed"><iframe width="420" height="315" frameborder="0" allowfullscreen="true" src="//player.vimeo.com/video/3300155"></iframe></div></div>'
  end

  it 'transform vimeo url without www' do
    result = subject.call('https://vimeo.com/3300155')
    expect(result).to eq '<div class="video vimeo"><div class="responsive-embed"><iframe width="420" height="315" frameborder="0" allowfullscreen="true" src="//player.vimeo.com/video/3300155"></iframe></div></div>'
  end

  it 'transform vimeo url with params' do
    result = subject.call('http://vimeo.com/3300155?pg=embed&sec=')
    expect(result).to eq '<div class="video vimeo"><div class="responsive-embed"><iframe width="420" height="315" frameborder="0" allowfullscreen="true" src="//player.vimeo.com/video/3300155"></iframe></div></div>'
  end

  it 'transform vimeo url with anchor' do
    result = subject.call('http://vimeo.com/3300155#skirt')
    expect(result).to eq '<div class="video vimeo"><div class="responsive-embed"><iframe width="420" height="315" frameborder="0" allowfullscreen="true" src="//player.vimeo.com/video/3300155"></iframe></div></div>'
  end

  it 'transform vimeo url wth options' do
    filter = described_class.new(width: 300, height: 250)
    result = filter.call('http://www.vimeo.com/3300155')
    expect(result).to eq '<div class="video vimeo"><div class="responsive-embed"><iframe width="300" height="250" frameborder="0" allowfullscreen="true" src="//player.vimeo.com/video/3300155"></iframe></div></div>'
  end

  it 'does not transform vimeo url inside an anchor tag with double quotes' do
    result = subject.call('<a href="http://www.vimeo.com/3300155">vimeo</a>')
    expect(result).to eq '<a href="http://www.vimeo.com/3300155">vimeo</a>'
  end

  it 'does not transform vimeo url inside an anchor tag with single quotes' do
    result = subject.call("<a href='http://www.vimeo.com/3300155'>vimeo</a>")
    expect(result).to eq "<a href='http://www.vimeo.com/3300155'>vimeo</a>"
  end
end

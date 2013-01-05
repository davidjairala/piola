# encoding: utf-8
require 'spec_helper'

describe Piola::Uri do

  describe '#uri_escape' do

    it "should correctly escape uris" do
      url = 'http://andes.info.ec/economía/8150.html'
      url.uri_escape.should eql('http://andes.info.ec/econom%C3%ADa/8150.html')
    end

  end

  describe '#uri_unescape' do

    it "should correctly unescape uris" do
      url = 'http://andes.info.ec/econom%C3%ADa/8150.html'
      url.uri_unescape.should eql('http://andes.info.ec/economía/8150.html')
    end

  end

end
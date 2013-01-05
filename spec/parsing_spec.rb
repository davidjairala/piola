# encoding: utf-8
require 'spec_helper'

describe Piola::Parsing do

  describe '#remove_all_parenthesis' do

    it "should remove all parenthesis" do
      txt = '(foo) [bar] {baz} test'
      txt.remove_all_parenthesis.should eql('test')
    end

  end

  describe '#remove_enters' do

    it "should remove all kinds of enters" do
      txt = "foo\nbar\rbaz#{10.chr}test#{13.chr}another<br />line<br>yet<br/>not<BR />over<BR>never<BR/>ever"
      txt.remove_enters.should eql('foo bar baz test another line yet not over never ever')
    end

  end

  describe '#remove_extra_enters' do

    it "should only leave one enter per parragraph" do
      txt = "foo\n\nbar\n\n\nbaz test"
      txt.remove_extra_enters.should eql("foo\nbar\nbaz test")
    end

  end

  describe '#remove_quotes' do

    it "should remove all kinds of quotes" do
      txt = %Q{"foo" 'bar' baz}
      txt.remove_quotes.should eql('foo bar baz')
    end

  end

end
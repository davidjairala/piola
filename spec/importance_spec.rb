# encoding: utf-8
require 'spec_helper'

describe Piola::Importance do

  describe '#count_words' do

    it "should count the quantity of words in a string" do
      'foo bar baz'.count_words.should eql(3)
    end

  end

  describe '#longest_parragraph' do

    it "should fetch the longest parragraph from a text" do
      txt = "this is the first parragraph\nthis is quite the longest parragraph by far as far as the eye can see\nanother for good measure"
      txt.longest_parragraph.should eql('this is quite the longest parragraph by far as far as the eye can see')
    end

  end

  describe '#important_words' do

    it "should fetch the most important words from a text" do
      txt = "Incrementar bonificación es la oferta común de precandidatos"
      txt.important_words.should eql('Incrementar bonificación oferta común precandidatos')
    end

  end

  describe '#just_words' do

    it "should return just the most important clean words of a string" do
      txt = "Incrementar bonificación es la oferta común de precandidatos (other not important stuff)"
      txt.just_words.should eql('incrementar bonificacion oferta comun precandidatos')
    end

    it 'strips quotes (even weird ones)' do
      txt = "‘assange esta peor que una prision’ \"more quotes\""
      txt.just_words.should eql('assange esta peor prision more quotes')
    end

    it 'removes words with equal or less than 3 chars' do
      txt = "this is a test"
      txt.just_words.should eql('this test')
    end

    it "doesn't remove words with 3 chars when option is passed" do
      txt = "this is a test"
      txt.just_words(small_words: true).should eql('this is a test')
    end

  end

end
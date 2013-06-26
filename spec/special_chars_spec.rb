# encoding: utf-8
require 'spec_helper'

describe Piola::SpecialChars do

  describe '#spanish_char?' do

    %w(á é í ó ö ú ñ Á É Í Ö Ó Ú Ñ).each do |char|

      it "identifies `#{char}` as spanish char" do
        char.should be_spanish_char
      end

    end

  end

  describe '#only_letters' do

    it "should remove all weird chars" do
      txt = "foóo báar bañz ñoün FÓO BÁAR ÑOÜN 123test"
      txt.only_letters.should eql('foóo báar bañz ñoün FÓO BÁAR ÑOÜN test')
    end

  end

  describe '#clean_chars' do

    it "returns a clean string with no weird chars" do
      txt = "RT @ipbc79: Pasajes de avion ✔ hotel reservado ✔ boletos ✔ .... 🔜 Nos vemos el 31 de octubre @justinbieber #Ecuador"
      txt.clean_chars.should eql "RT @ipbc79: Pasajes de avion hotel reservado boletos Nos vemos el 31 de octubre @justinbieber #Ecuador"
    end

  end

  describe '#downcase_special_chars' do

    it "downcases all special chars" do
      txt = 'ÁÉÍÓÚÜÑ'
      txt.downcase_special_chars.should eql('áéíóúüñ')
    end

  end

  describe '#remove_special_chars' do

    it "should replace spanish special chars" do
      txt = 'áéíóúüñÁÉÍÓÚÜÑ'
      txt.remove_special_chars.should eql('aeiouunAEIOUUN')
    end

  end

  describe '#clean_text' do

    let(:txt) { "  foo bar   baz &aacute;&ntilde; test (another test)\n\nsome enters  " }

    it "should return a clean string" do
      txt.clean_text.should eql('foo bar baz áñ test some enters')
    end

    it "should leave parenthesis when specified" do
      txt.clean_text(false).should eql('foo bar baz áñ test (another test) some enters')
    end

  end

  describe '#remove_tabs' do

    it "should correctly remove tabs" do
      txt = "\t\t  foo bar \t baz  "
      txt.remove_tabs.should eql('foo bar baz')
    end

  end

end
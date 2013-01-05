# encoding: utf-8
require 'spec_helper'

describe Piola::Encoding do

  describe '#to_iso' do

    it "should correctly convert an UTF8 string to ISO" do
      'ááá'.to_iso.should_not be_utf8
      'ááá'.to_iso.should be_iso
    end

  end

  describe '#to_utf8' do

    it "should correctly convert an ISO string to UTF8" do
      'ááá'.force_encoding('ISO-8859-1').to_utf8.should eql('ááá')
      'ááá'.force_encoding('ISO-8859-1').to_utf8.should be_utf8
    end

    it "should correctly convert an UTF8 string to ISO and back" do
      'á'.to_iso.to_utf8.should eql('á')
      'á'.to_iso.to_utf8.should be_utf8
    end

  end

  describe '#utf8?' do
    it { 'foo bar baz'.should be_utf8 }
    it { 'ááá'.should         be_utf8 }
  end

  describe '#iso?' do
    it { 'á'.to_iso.should be_iso }
  end

end
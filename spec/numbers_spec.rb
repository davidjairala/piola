# encoding: utf-8
require 'spec_helper'

describe Piola::Numbers do

  describe '#valid_number?' do

    it "should return true for whole number" do
      '15'.should be_valid_number
    end

    it "should return true for fractions" do
      '7.50'.should be_valid_number
    end

    it "should return true for negative numbers" do
      '-7.50'.should be_valid_number
    end

    it "should return true for big numbers" do
      '15000000.55'.should be_valid_number
    end

    it "should return false for text" do
      'foo'.should_not be_valid_number
    end

    it "shoul return false for text with numbers" do
      'foo 15'.should_not be_valid_number
      'foo 15 bar'.should_not be_valid_number
    end

  end

  describe '#remove_numbers' do

    it "should correctly remove number parragraphs from a text" do
      text = "15\nthis is a test line\n30\nanother test line"
      text.remove_numbers.should eql("this is a test line\nanother test line")
    end

    it "should ignore numbers that are part of sentences" do
      text = "15\nthis is a 30 test line\n30\nanother 40 test line"
      text.remove_numbers.should eql("this is a 30 test line\nanother 40 test line")
    end

  end

end
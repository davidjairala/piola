# encoding: utf-8
require 'spec_helper'

describe Piola::Sql do

  describe '#sql_search' do

    it "should convert the string to a sql search query" do
      txt = "foo bar baz"
      fields = %w(title description)
      txt.sql_search(fields).should eql("((title LIKE \"%foo%\") AND (title LIKE \"%bar%\") AND (title LIKE \"%baz%\")) OR ((description LIKE \"%foo%\") AND (description LIKE \"%bar%\") AND (description LIKE \"%baz%\"))")
    end

  end

  describe '#searchify' do

    let(:fields) { %w(title description) }

    it "should convert the string sql search query" do
      txt = "foo bar baz"
      txt.searchify(fields).should eql("(title LIKE \"%foo%\" AND title LIKE \"%bar%\" AND title LIKE \"%baz%\" OR description LIKE \"%foo%\" AND description LIKE \"%bar%\" AND description LIKE \"%baz%\")")
    end

    it "should permit exact matching" do
      txt = 'foo bar "exact phrase"'
      txt.searchify(fields).should eql("(title LIKE \"%exact phrase%\" AND title LIKE \"%foo%\" AND title LIKE \"%bar%\" OR description LIKE \"%exact phrase%\" AND description LIKE \"%foo%\" AND description LIKE \"%bar%\")")
    end

    it "should permit exact word matching" do
      txt = 'foo bar "exact phrase" `football`'
      txt.searchify(fields).should eql("((title LIKE \"% football %\" OR title LIKE \"% football.%\" OR title LIKE \"% football,%\") AND title LIKE \"%exact phrase%\" AND title LIKE \"%foo%\" AND title LIKE \"%bar%\" OR (description LIKE \"% football %\" OR description LIKE \"% football.%\" OR description LIKE \"% football,%\") AND description LIKE \"%exact phrase%\" AND description LIKE \"%foo%\" AND description LIKE \"%bar%\")")
    end

    it "should permit excluding words" do
      txt = "foo bar -baz"
      txt.searchify(fields).should eql("(title LIKE \"%foo%\" AND title LIKE \"%bar%\" OR description LIKE \"%foo%\" AND description LIKE \"%bar%\") AND (title NOT LIKE \"%baz%\" AND description NOT LIKE \"%baz%\")")
    end

    it "should permit exact excludes" do
      txt = 'foo bar -"exact phrase"'
      txt.searchify(fields).should eql("(title LIKE \"%foo%\" AND title LIKE \"%bar%\" OR description LIKE \"%foo%\" AND description LIKE \"%bar%\") AND (title NOT LIKE \"%exact phrase%\" AND description NOT LIKE \"%exact phrase%\")")
    end

    it "should permit exact word excludes" do
      txt = 'foo bar -`exact phrase`'
      txt.searchify(fields).should eql("(title LIKE \"%foo%\" AND title LIKE \"%bar%\" OR description LIKE \"%foo%\" AND description LIKE \"%bar%\") AND ((title NOT LIKE \"% exact phrase %\" OR title NOT LIKE \"% exact phrase.%\" OR title NOT LIKE \"% exact phrase,%\") AND (description NOT LIKE \"% exact phrase %\" OR description NOT LIKE \"% exact phrase.%\" OR description NOT LIKE \"% exact phrase,%\"))")
    end

    it "should permit mixing all the options" do
      txt = 'foo -bar "exact phrase" -"exact exclude phrase"'
      txt.searchify(fields).should eql("(title LIKE \"%exact phrase%\" AND title LIKE \"%foo%\" OR description LIKE \"%exact phrase%\" AND description LIKE \"%foo%\") AND (title NOT LIKE \"%exact exclude phrase%\" AND title NOT LIKE \"%bar%\" AND description NOT LIKE \"%exact exclude phrase%\" AND description NOT LIKE \"%bar%\")")
    end

    it "should allow setting the operator" do
      txt = "foo bar baz"
      txt.searchify(fields, operator: :or).should eql("(title LIKE \"%foo%\" OR title LIKE \"%bar%\" OR title LIKE \"%baz%\" OR description LIKE \"%foo%\" OR description LIKE \"%bar%\" OR description LIKE \"%baz%\")")
    end

  end

end
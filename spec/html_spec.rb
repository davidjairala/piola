# encoding: utf-8
require 'spec_helper'

describe Piola::Html do

  describe '#strip_tags' do

    it "should remove tags from html docs" do
      txt = '<div id="baz_id"><p>foo bar baz.<br></p></div><div style="clear:both;"></div>'
      txt.strip_tags.should eql('foo bar baz.')
    end

    it "removes quoted tags" do
      txt = '&lt;div id="baz_id"&gt;&lt;p&gt;foo bar baz.&lt;br&gt;&lt;/p&gt;&lt;/div&gt;&lt;div style="clear:both;"&gt;&lt;/div&gt;'
      txt.strip_tags.should eql('foo bar baz.')
    end

  end

  describe '#strip_tags_enters' do

    let(:txt) { %Q{<div id="baz_id">
                <p>
                  foo (bar) baz.
                  <br>
                </p>
              </div><div style="clear:both;"></div>} }

    it "should remove tags but leave enters in their places" do
      txt.strip_tags_enters.should eql("\n\n\n\nfoo baz.\n\n\n\n\n")
    end

    it "should not remove parenthesis when specified" do
      txt.strip_tags_enters(false).should eql("\n\n\n\nfoo (bar) baz.\n\n\n\n\n")
    end

  end

  describe '#html_encode' do

    it "should convert special chars to html entities" do
      txt = 'áéíñÑÁ'
      txt.html_encode.should eql('&aacute;&eacute;&iacute;&ntilde;&Ntilde;&Aacute;')
    end

  end

  describe '#html_decode' do

    it "should convert html entities to special chars" do
      txt = 'áéíñÑÁ'
      txt.html_encode.should eql('&aacute;&eacute;&iacute;&ntilde;&Ntilde;&Aacute;')
    end

  end

  describe '#html_leftover?' do

    it 'returns true if the string has any html leftovers' do
      txt = '/* Style Definitions */ table MsoNormalTable mso-style-name:"Tabla normal"; mso-tstyle-rowband-size:0; mso-tstyle-colband-size:0; mso-style-noshow:yes; mso-style-priority:99; mso-style-parent:""; mso-padding-alt:0cm 5 4pt 0cm 5 4pt; mso-para-margin:0cm; mso-para-margin-bottom: 0001pt; mso-pagination:widow-orphan; font-size:10 0pt; font-family:"Calibri" "sans-serif"; mso-bidi-font-family:"Times New Roman";'
      txt.should be_html_leftover
    end

    it 'returns true for strings with brackets' do
      'this is {a test'.should              be_html_leftover
      'this is }another test'.should        be_html_leftover
      'this { is yet another } test'.should be_html_leftover
    end

    it 'returns true for strings with < or >' do
      'this is <a test'.should              be_html_leftover
      'this is >another test'.should        be_html_leftover
      'this < is yet another > test'.should be_html_leftover
    end

    it 'returns false if normal string' do
      txt = 'Hasta ayer no se confirmó que el mandatario vaya a ofrecer alguna rueda de prensa o visite algún medio de comunicación tampoco se conoce sobre la agenda que vaya a tener luego de culminada la grabación del programa sabatino'
      txt.should_not be_html_leftover
    end

  end

end
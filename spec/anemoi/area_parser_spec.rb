# encoding: utf-8

require "spec_helper"

describe Anemoi::AreaParser do
  describe "#city_by_pref" do
    it "県を入力して県庁所在地を出力する" do
      city = Anemoi::AreaParser.city_by_pref('群馬')
      city.should == '前橋'
    end

    it "県が含まれなかったら入力をそのまま返す" do
      city = Anemoi::AreaParser.city_by_pref('ニャッス')
      city.should == 'ニャッス'
    end
  end

  describe "#info_by_city" do
    it "町が含まれたテキストからidと町の名前を返す" do
      Anemoi::AreaParser.info_by_city('前橋〜〜').should == { :id => 58, :name => '前橋' }
    end
  end

  describe "#parse" do
    it "県が含まれた文字列からidを返す" do
      Anemoi::AreaParser.parse('明日の群馬の天気など')[:id].should == 58
    end

    it "県が含まれなかったらnilを返す" do
      Anemoi::AreaParser.parse('明日の天気など').should be_nil
    end

    it "京都東京都" do
      Anemoi::AreaParser.info_by_city('京都')[:id].should == 79
      Anemoi::AreaParser.info_by_city('東京都')[:id].should == 63
    end

    it "津" do
      Anemoi::AreaParser.info_by_city('津')[:name].should == '津'
      Anemoi::AreaParser.info_by_city('大津')[:name].should == '大津'
    end

    it "宮古島宮古" do
      Anemoi::AreaParser.info_by_city('宮古')[:name].should == '宮古'
      Anemoi::AreaParser.info_by_city('宮古島')[:name].should == '宮古島'
    end
  end
end

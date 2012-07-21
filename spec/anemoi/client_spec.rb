# encoding: utf-8

require "spec_helper"

describe Anemoi::Client do
  describe "#horai_date_parse" do
    before do
      @anemoi = Anemoi::Client.new
    end

    it "明日" do
      @anemoi.horai_date_parse("明日の天気").should == :tomorrow
    end
    it "明後日" do
      @anemoi.horai_date_parse("明後日の天気").should == :day_after_tomorrow
    end
    it "指定がない場合" do
      @anemoi.horai_date_parse("あれ").should be_nil
    end
  end

  describe "#get_weather" do
    result = Anemoi::Client.new.get_weather("群馬の天気")
    it "result" do
      result[:location][:city].should == "前橋"
      result[:forecastday].should == :today
      result[:weather].should =~ /[晴曇雨]/
    end

    describe "指定した日と場所" do
      it "指定した場合" do
        result = Anemoi::Client.new.get_weather("群馬の天気")
        result[:specified][:city].should be_kind_of Hash
      end
      it "指定しない場合[:specified][:city]はnil" do
        result = Anemoi::Client.new.get_weather("天気")
        result[:specified][:city].should be_nil
      end
      it "時間を指定しない場合は今日" do
        result = Anemoi::Client.new.get_weather("天気")
        result[:forecastday].should == :today
      end
      it "場所を指定しない場合は東京" do
        result = Anemoi::Client.new.get_weather("天気")
        result[:location][:city].should == "東京"
      end
    end
  end

  it "Anemoi.get_weather" do
    Anemoi.get_weather("明日の広島")[:weather].should =~ /[晴曇雨]/
  end
end

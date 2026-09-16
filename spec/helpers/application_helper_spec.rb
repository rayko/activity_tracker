require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#month_name" do
    it "returns month name of given date" do
      date = Date.parse("2026-07-05")
      expect(helper.month_name(date)).to eq("July")
    end
  end

  describe "#blue_btn_class" do
    it "returns string" do
      expect(String === helper.blue_btn_class).to eq(true)
    end
  end

  describe "#regular_btn_class" do
    it "returns string" do
      expect(String === helper.regular_btn_class).to eq(true)
    end
  end

  describe "#regular_red_btn_class" do
    it "returns string" do
      expect(String === helper.regular_red_btn_class).to eq(true)
    end
  end

  describe "#link_to_back" do
    it "returns link" do
      expect(helper.link_to_back).to have_link("Back", href: "javascript:history.back()")
    end
  end

  describe "#login_link_btn" do
    it "returns link" do
      expect(helper.login_link_btn("Custom", "/somewhere")).to have_link("Custom", href: "/somewhere")
    end
  end
end

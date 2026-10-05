require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe "#month_name" do
    it "returns month name of given date" do
      date = Date.parse("2026-07-05")
      expect(helper.month_name(date)).to eq("July")
    end
  end

  describe "#blue_btn_class" do
    it "returns string" do
      expect(String === helper.blue_btn_class).to be(true)
    end
  end

  describe "#regular_btn_class" do
    it "returns string" do
      expect(String === helper.regular_btn_class).to be(true)
    end
  end

  describe "#regular_red_btn_class" do
    it "returns string" do
      expect(String === helper.regular_red_btn_class).to be(true)
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

  describe "#daily_pace" do
    let(:user) { create :user }

    before do
      other_user = create :user
      other_act = create :activity, user: other_user
      create :activity_hit, activity: other_act

      act1 = create :activity, user: user
      act2 = create :activity, user: user, archived: true

      create :activity_hit, activity: act1, date: 2.days.ago
      create :activity_hit, activity: act2, date: 1.day.ago
      create :activity_hit, activity: act1, date: 3.days.ago
      create :activity_hit, activity: act1, date: 10.days.ago
    end

    it "returns average hit count in past 7 days" do
      expect(helper.daily_pace(user)).to eq((3.0 / 7).round(2))
    end
  end
end

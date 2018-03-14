require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_array_all = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    student_roster = doc.css(".roster-cards-container .student-card")
    student_roster.each do |student|
      student_hash = Hash.new
      student_hash[:name] = student.css(".student-name").text
      student_hash[:location] = student.css(".student-location").text
      student_hash[:profile_url] = student.css("@href").text
      student_array_all << student_hash
    end
    student_array_all
  end

  def self.scrape_profile_page(profile_url)
    student_profile = Hash.new
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    # social links
    social_info = doc.css(".vitals-container .social-icon-container @href")
    social_info.each do |link|
      social_com = link.text.split(".com")[0]
      social_name = social_com.split(".")[-1]
      if social_name.include?("twitter") == true
        student_profile[:twitter] = link.text
      elsif social_name.include?("linkedin") == true
        student_profile[:linkedin] = link.text
      elsif social_name.include?("github") == true
        student_profile[:github] = link.text
      else
        student_profile[:blog] = link.text
      end
    end

    # quote
    profile_quote = doc.css(".vitals-container .vitals-text-container .profile-quote").text
    student_profile[:profile_quote] = profile_quote

    # bio
    profile_bio = doc.css(".details-container .description-holder p").text
    student_profile[:bio] = profile_bio

    student_profile
  end

end

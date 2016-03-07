require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_array = []

    doc = Nokogiri::HTML(open(index_url))
    students = doc.css(".student-card")

    students.each do |i|
      student_array << {name: i.css("h4").text, location: i.css("p").text, profile_url: "#{"http://127.0.0.1:4000/"}" + i.css("a").attribute("href")}
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    student_profile = Hash.new

    doc = Nokogiri::HTML(open(profile_url))
    social_profiles = doc.css("div.social-icon-container")


    social_profiles.css("a").each do |i|
      if i.attribute("href").text.include? "twitter"
        student_profile[:twitter] = i.attribute("href").text
      elsif i.attribute("href").text.include? "linkedin"
        student_profile[:linkedin] = i.attribute("href").text
      elsif i.attribute("href").text.include? "github"
        student_profile[:github] = i.attribute("href").text
      else
        student_profile[:blog] = i.attribute("href").text
      end
    end

    student_profile[:profile_quote] = doc.css("div.profile-quote").text
    student_profile[:bio] = doc.css("div.description-holder p").text

    student_profile
  end
end

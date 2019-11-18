require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    student_names = doc.css(".student-name")
    student_locations = doc.css(".student-location")
    student_profile_urls = doc.css(".student-card a[href]")
    student_names.each_with_index do |name, i|
      students << {name: name.text, location: student_locations[i].text, profile_url: student_profile_urls[i].values[0]}
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    student_profile = {}
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    student_profile[:profile_quote] = doc.css(".profile-quote").text
    student_profile[:bio] = doc.css(".description-holder p").text
    doc.css(".social-icon-container a[href]").each do |network|
      if network.values[0].include?("twitter")
        student_profile[:twitter] = network.values[0]
      elsif network.values[0].include?("linked")
        student_profile[:linkedin] = network.values[0]
      elsif network.values[0].include?("github")
        student_profile[:github] = network.values[0]
      else
        student_profile[:blog] = network.values[0]
      end
    end
    student_profile
  end

end

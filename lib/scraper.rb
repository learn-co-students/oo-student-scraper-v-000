require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    student_array = []
    doc.css(".student-card").each do |student|
      student_hash = {}
      student_hash[:profile_url] = student.css("a").attribute("href").value
      student_hash[:name] = student.css("h4").text
      student_hash[:location] = student.css("p").text
      student_array.push(student_hash)
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
      social_hash = {}
    doc.css(".social-icon-container a").each do |social|
      link = social.attribute("href").value
      if link.include?("twitter")
      social_hash[:twitter] = link
        elsif link.include?("github")
          social_hash[:github] = link
        elsif link.include?("linkedin")
          social_hash[:linkedin] = link
        else
          social_hash[:blog] = link
        end
     end
      social_hash[:profile_quote] = doc.css(".profile-quote").text
      social_hash[:bio] = doc.css("p").text
      social_hash
  end
end

# twitter url, linkedin url, github url, blog url, profile quote, and bio

#
# doc.css(".grey-text").text
#  => "350+ lives changed,and counting."
#
# instructors = doc.css("#instructors .team-holder .person-box")
#
# instructors.each do |instructor|
#   puts "Flatiron School <3 " + instructor.css("h2").text
# end

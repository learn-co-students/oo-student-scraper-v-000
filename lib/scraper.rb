require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    student_data = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)

    doc.css("div.student-card").each do |student|
     name = student.css(".student-name").text
     location = student.css(".student-location").text
     profile_url = student.css("a").attribute("href").value
     student_info = {:name => name,
               :location => location,
               :profile_url => profile_url}
     student_data << student_info
     end
   student_data
  end



  def self.scrape_profile_page(profile_url)
  html = open(profile_url)
  doc = Nokogiri::HTML(html)
  links = []
  profile_hash = {}
  doc.css("div.social-icon-container a").each do |social|
    links << social['href']
  end
 links.each do |link|
   if link.include?("twitter")
          profile_hash[:twitter] = link
        elsif link.include?("linkedin")
          profile_hash[:linkedin] = link
        elsif link.include?("github")
          profile_hash[:github] = link
        elsif link.include?(".com")
          profile_hash[:blog] = link
        end
        profile_quote = doc.css(".profile-quote").text
       bio = doc.css('div.description-holder p').text
       profile_hash[:profile_quote] = profile_quote
       profile_hash[:bio] = bio
end
profile_hash
end

end

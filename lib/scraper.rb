require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_cards = doc.css(".student-card")
    student_cards.collect do |student| {
         name: student.css(".student-name").text,
         location: student.css(".student-location").text,
         profile_url: student.css("a").attr("href").text
       }
     end
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    social_media = doc.css("div.social-icon-container a")
    profile = {}
    social_media.each do |link|
      link = link.attr("href")
      if link.include?("twitter")
        profile[:twitter] = link
      elsif link.include?("github")
        profile[:github] = link
      elsif link.include?("linkedin")
        profile[:linkedin] = link
      else
       profile[:blog] = link
     end
   end

   profile[:profile_quote] = doc.css(".profile-quote").text
   profile[:bio] = doc.css(".bio-content p").text

   profile
 end

end

require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
   html = File.read(index_url)
   doc = Nokogiri::HTML(html)
   students = []
   doc.css("div.student-card").each do |card|
     students << {
       :name => card.css("div.card-text-container h4.student-name").text,
       :location => card.css("div.card-text-container p.student-location").text,
       :profile_url => "./fixtures/student-site/#{card.css("a").attribute("href").value}"
     }
   end
   students
  end


  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    profile = Nokogiri::HTML(html)
    student_details = {
      :profile_quote => profile.css("div.vitals-text-container div.profile-quote").text,
      :bio => profile.css("div.bio-content div.description-holder p").text
    }
    social_links = []
    profile.css("div.social-icon-container a").each do |link|
      social_links << link.attribute("href").text
    end

    social_links.each do |social|
      if social.scan(/twitter/) !=[]
        student_details[:twitter] = social
      elsif social.scan(/github/) != []
        student_details[:github] = social
      elsif social.scan(/linkedin/) != []
        student_details[:linkedin] = social
      else
       student_details[:blog] = social
      end
    end
     student_details
  end

end

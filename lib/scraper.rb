require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index = Nokogiri::HTML(open(index_url))
    students = []
    
    index.css("div.student-card").each do |student_card|
     students << {
        name: student_card.css("a div.card-text-container h4.student-name").text,
        location: student_card.css("a div.card-text-container p.student-location").text,
        profile_url: ("http://students.learn.co/" << student_card.css("a").attribute("href").value)
      }
    end
    students
  end


  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    links = profile.css("div.social-icon-container a")
    profile_attr = {}
    links.each do |link|
      if link.attribute("href").value.scan(/twitter/) == ["twitter"]
        method = 'twitter'
      elsif link.attribute("href").value.scan(/linkedin/) == ["linkedin"]
        method = 'linkedin'
      elsif link.attribute("href").value.scan(/github/) == ["github"]
        method = 'github'
      elsif link.css("img").attribute("src").value.scan(/rss-icon/) == ['rss-icon']
        method = 'blog'
      end
      profile_attr[method.to_sym] = link.attribute("href").value unless method == nil
    end
    profile_attr[:profile_quote] = profile.css("div.profile-quote").text.scan(/\b\w+\b/).join" " 
    profile_attr[:bio] = profile.css("div.description-holder p").text
    profile_attr
  end
end



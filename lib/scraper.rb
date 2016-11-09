require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    index=Nokogiri::HTML(open(index_url))
    r=[]
    index.css(".student-card").each do |student|
      r<<{name: student.css(".student-name").text,
         location: student.css(".student-location").text,
         profile_url: index_url[0..-11]+student.css("a").attribute("href").value}
    end
    r
  end

  def self.scrape_profile_page(profile_url)
    profile=Nokogiri::HTML(open(profile_url))
    r={}
    labels=[:twitter,:linkedin,:github,:blog]
    r[:profile_quote]=profile.css(".profile-quote").first.text
    r[:bio]=profile.css(".bio-content .description-holder p").first.text
    profile.css(".social-icon-container a").each do |item|
      labels.each do |lab|
         s="../assets/img/#{lab==:blog ? :rss : lab}-icon.png"
         if item.css("img").first.attribute("src").value==s
            r[lab]=item.attribute("href").value
         end
      end
    end
    r
  end

end


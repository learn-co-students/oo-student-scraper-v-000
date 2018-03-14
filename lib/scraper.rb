require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    #Below method is an optional method for non-live page scraping and can be applied here instead of above
    #html = File.read(index_url)
    #index_page = Nokogiri::HTML(html)

    student_index = [] #This method's required output is an Array

    index_page.css("div.student-card").each do |student|
      student_hash = {
        :name => student.css("a").css("div.card-text-container h4").text,
        :location => student.css("a").css("div.card-text-container p").text,
        :profile_url => "./fixtures/student-site/" + student.css("a").attribute("href").value
      }
      student_index << student_hash
    end
    student_index
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))

    profile = {} #This method's required output is a Hash

    #Compile social media links
    social_container = profile_page.css("div.social-icon-container")
    social_container.css("a").each do |link|
      media = link.css("img.social-icon").attribute("src").value
      key = File.basename(media, ".png").chomp("-icon")
      if key == "rss"
        profile[:blog] = link.attribute("href").value
      else
        profile[key.to_sym] = link.attribute("href").value
      end
    end

    #Profile Quote
    quote_container = profile_page.css("div.vitals-text-container")
    profile[:profile_quote] = quote_container.css("div.profile-quote").text

    #Bio
    detail_container = profile_page.css("div.details-container")
    profile[:bio] = detail_container.css("div.bio-content.content-holder div.description-holder p").text

    profile
  end
  
end

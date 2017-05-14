require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)

    page = Nokogiri::HTML(open(index_url))
    card_container = page.css('.student-card')

    #iterates throught the student_container create a hash for each.
    #:name :location and :profile_url
    card_container.collect do |k|
          {
          "name":k.css('.student-name').text, "location":k.css('.student-location').text,
          "profile_url": k.css("a")[0]["href"]
            }
         end
  end

      #iterates throught the student profile adds social media to a hash.
  def self.scrape_profile_page(profile_url)
     page  = Nokogiri::HTML(open(profile_url))
     socialMedia  = page.css("div.social-icon-container")
     hash  = Hash.new
      socialMedia.css("a").each do |k| url = k["href"]
          if url.include?("twitter.com")
          hash[:"twitter"] =  url
        elsif url.include?("linkedin.com")
          hash[:"linkedin"] =  url
        elsif url.include?("github.com")
          hash[:"github"] =  url
        else
          hash[:"blog"] = url
        end
      end

      if  page.css("div.profile-quote").text != nil
        hash[:"profile_quote"] = page.css("div.profile-quote").text
      end

      if  page.css("div.description-holder p").text !=nil
        hash[:"bio"] = page.css("div.description-holder p").text
      end
    hash
 end






end

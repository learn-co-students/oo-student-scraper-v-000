require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    scraped_students = []
    doc.css("div.student-card").collect do |student|
       {
       :name => student.css("h4.student-name").text,
       :location => student.css("p.student-location").text,
       :profile_url => index_url + student.css("a").attribute("href").value
       }
    end
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile_hash = {:profile_quote => doc.css("div.profile-quote").text,
                       :bio => doc.css("div.description-holder p").text
                      }

    doc.css("div.social-icon-container a").each do |link|
      url = link.attribute("href").value

      if url.include?("twitter")
        profile_hash[:twitter] = url
      elsif url.include?("linkedin")
        profile_hash[:linkedin] = url
      elsif url.include?("github")
        profile_hash[:github] = url
      else
        profile_hash[:blog] = url
      end
    end
    profile_hash
  end

end

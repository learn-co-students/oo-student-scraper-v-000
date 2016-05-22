require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    scraped_students = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css("div.student-card").collect do |student|
      {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => index_url + student.css("a").attribute("href").value
      }
    end
  end



  def self.scrape_profile_page(profile_url)
    # responsible for scraping individual student's profile page to get further
    # information about that student
    doc = Nokogiri::HTML(open(profile_url))
    profile = {:profile_quote => doc.css("div.profile-quote").text,
                :bio => doc.css("div.description-holder p").text}
    doc.css("div.social-icon-container a").each do |links|
      url = links.attribute("href").value
      if url.include?("twitter")
        profile[:twitter] = url
      elsif url.include?("linkedin")
        profile[:linkedin] = url
      elsif url.include?("github")
        profile[:github] = url
      else
        profile[:blog] = url
      end
    end
    profile

  end

end


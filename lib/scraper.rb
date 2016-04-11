require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)

    doc = Nokogiri::HTML(open(index_url))

    doc.css("div.student-card").map do |student|
      {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => "http://127.0.0.1:4000/"+ student.css("a").attribute("href").value
      }
    end
  end

  def self.scrape_profile_page(profile_url)

    doc = Nokogiri::HTML(open(profile_url))

    profile = {}
    doc.css("div.social-icon-container a").each do |student|
      profile_page = student.attribute("href").value

      if profile_page.include?("twitter")
        profile[:twitter] = profile_page
      elsif profile_page.include?("linkedin")
        profile[:linkedin] = profile_page
      elsif profile_page.include?("github")
        profile[:github] = profile_page
      else
        profile[:blog] = profile_page
      end
    end

    profile[:profile_quote] = doc.css(".profile-quote").text
    profile[:bio] = doc.css(".description-holder p").text

    profile
  end
end

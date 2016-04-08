require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    doc.css("div.student-card").collect do |student|
      {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => "http://127.0.0.1:4000/" + student.css("a").attribute("href").value
      }
    end
  end

  def self.scrape_profile_page(profile_url)
      student = Nokogiri::HTML(open(profile_url))

      #twitter url, linkedin url, github url, blog url, profile quote, and bio
      profile = {}
      student.css("div.social-icon-container a").each do |s|
        profile_page = s.attribute("href").value
        if profile_page.include?("twitter")
          profile[:twitter] = profile_page
        elsif profile_page.include?("linkedin")
          profile[:linkedin] = profile_page
        elsif profile_page.include?("github")
          profile[:github] = profile_page
        else
          profile[:blog] = profile_page
        end
        p_quote = student.css("div.profile-quote").text
        bio_p = student.css("div.description-holder p").text

        profile[:profile_quote] = p_quote
        profile[:bio] = bio_p
      end
      profile
    end
end

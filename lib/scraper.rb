require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    index_url = Nokogiri::HTML(html)
    # binding.pry
    index_url.css("div.student-card").map{|card|

      student = {
        :name => card.css("h4.student-name").text,
        :location => card.css("p.student-location").text,
        :profile_url => card.css("a").attribute("href").value

      }
      
      student
    }
  end

  def self.scrape_profile_page(profile_url)

    html = File.read(profile_url)
    profile_url = Nokogiri::HTML(html)
    links = profile_url.css("div.social-icon-container").css("a").map{|li| li.attribute("href").value}
    profile = {}
    # binding.pry
    links.each do |link|

      if link.include?("twitter")
        profile[:twitter] = link
      elsif link.include?("linkedin")
        profile[:linkedin] = link
      elsif link.include?("github")
        profile[:github] = link
      else
        profile[:blog] = link
      end
    end
      profile[:profile_quote] = profile_url.css("div.profile-quote").text
      profile[:bio] = profile_url.css("div.description-holder").css("p").text
      profile
  end
end

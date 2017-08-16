require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    info = Nokogiri::HTML(html)
    scraped_students = []

    info.css("div.student-card").each {|student|
      scraped_students << {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
    }
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    info = Nokogiri::HTML(html)
    profile = {}
    info.css(".social-icon-container a").each {|link|
      social = link["href"]
      case social
      when /twitter/
        profile[:twitter] = social
      when /linkedin/
        profile[:linkedin] = social
      when /github/
        profile[:github] = social
      when /http:/
        profile[:blog] = social
      end
    }
    profile[:profile_quote] = info.css("div.profile-quote").text
    profile[:bio] = info.css("div.description-holder p").text
    profile
  end

end

require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []

    Nokogiri::HTML(open(index_url)).css('.student-card').each { | student |
      students << {
        :name => student.css(".card-text-container h4").text,
        :location => student.css(".student-location").text,
        :profile_url => student.css("a").attribute("href").value,
      }
    }
    students
  end


  def self.scrape_profile_page(profile_url)
    attributes = {}

    page = Nokogiri::HTML(open(profile_url))

    attributes[:profile_quote] = page.css(".profile-quote").text
    attributes[:bio] = page.css(".description-holder p").text

    page.css(".social-icon-container a").each do | anchor |
      url = anchor.attribute("href").text
      if url =~ /twitter/
        attributes[:twitter]=url
      elsif url =~ /linkedin/
        attributes[:linkedin]=url
      elsif url =~ /github/
        attributes[:github]=url
      # spec doesn't care about youtube and facebook but we'll
      # handle those so they aren't mistaken for blog
      elsif url =~ /facebook/
        attributes[:facebook]=url
      elsif url =~ /youtube/
        attributes[:youtube]=url
      # assume anything else must be blog
      else
        attributes[:blog]=url
      end
    end

    attributes
  end

end

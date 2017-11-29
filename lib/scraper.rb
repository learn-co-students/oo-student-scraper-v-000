require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    student_array = []
    #name
    #location
    #profile url
    page = Nokogiri::HTML(open(index_url))

    student_list = page.css("div.student-card")
    student_list.each do |student|
      student_hash = {}
      url = student.css("a").first.attributes["href"].value

      name = student.css("h4.student-name").text

      location = student.css("p.student-location").text
      student_hash = {:name => name, :location =>location, :profile_url =>url}
      student_array<<student_hash
    end
    #div #roster-cards-container
    #div #student-card
      #a href
      #div card-text-container
      #h4 #student-name
      #p #student-location
      student_array
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    social_scrape = {}

    social_urls = profile.css("div.social-icon-container a").collect do |url|
      url.attributes["href"].value
    end

    if social_urls.find {|item| /twitter.com/ =~ item}
      social_scrape[:twitter]=social_urls.find {|item| /twitter.com/ =~ item}
    end

    if social_urls.find {|item| /linkedin.com/ =~ item}
      social_scrape[:linkedin]=social_urls.find {|item| /linkedin.com/ =~ item}
    end

    if social_urls.find {|item| /github.com/ =~ item}
      social_scrape[:github]=social_urls.find {|item| /github.com/ =~ item}
    end

    blog_collect = profile.css("div.social-icon-container a").collect do |url|
      if /rss-icon.png/ =~ url.children[0].attributes["src"].value
        url.attributes["href"].value
      end

    end
    blog_collect = blog_collect.compact
    if blog_collect[0]
      social_scrape[:blog]=blog_collect[0]
    end

    social_scrape[:profile_quote] = profile.css("div.profile-quote").text

    social_scrape[:bio] = profile.css("div.description-holder p").text

    #profile quote
    #div.profile_quote.text
    #bio
    #div.description-holder p .text
    social_scrape
  end

end

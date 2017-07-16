require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index = Nokogiri::HTML(open(index_url))
    students = []
    index.css("div.student-card").each do |item|
      student = {
        name: item.css("h4.student-name").text,
        location: item.css("p.student-location").text,
        profile_url: item.css("a").attribute("href").value
      }
      students << student
    end
    students
    # :profile_url => index.css("a").attribute("href").value
    # :name => index.css("div.card-text-container h4.student-name").text
    # :location => index.css("div.card-text-container p.student-location").text
  end

  def self.scrape_profile_page(profile_url)
    # html = open(profile_url)
    profile = Nokogiri::HTML(open(profile_url))

    social = []
    # get all the social elements - is there a better way to do this?
    profile.css("div.vitals-container div.social-icon-container a").each do |link|
      social << link.attribute("href").value
    end

    student = {
      twitter: social.detect {|url| url.match(/(twitter)/)},
      linkedin: social.detect {|url| url.match(/(linkedin)/)},
      github: social.detect {|url| url.match(/(github)/)},
      blog: social.detect {|url| !url.match(/(twitter)|(facebook)|(linkedin)|(github)/)},
      profile_quote: profile.css("div.profile-quote").text,
      bio: profile.css("div.bio-content div.description-holder p").text
    }
    # remove any nil values
    student.delete_if {|k, v| v.nil?}

    # #reject is like #delete_if but returns a copy of the hash => like usuing hash.dup.delete_if

    # elements needed: twitter url, linkedin url, github url, blog url, profile quote, and bio
      # how do you make sure that you pick twitter and linkedin? => use regex to make sure that the url has "https://twitter.com", "https://www.linkedin.com", "https://github.com", etc
      # twitter: social.detect {|url| url.match(/(twitter)/)}
      # linkedin: social.detect {|url| url.match(/(linkedin)/)}
      # github: social.detect {|url| url.match(/(github)/)}
      # blog: social.detect {|url| !url.match(/(twitter)|(facebook)|(linkedin)|(github)/)}
      # profile_quote: profile.css("div.vitals-text-container div.profile-quote").text
      # bio: profile.css("div.details-container div.bio-content div.description-holder p").text
      # social = []
        # profile.css("div.vitals-container div.social-icon-container a").each {|link| social << link.attribute("href").value}
  end

end

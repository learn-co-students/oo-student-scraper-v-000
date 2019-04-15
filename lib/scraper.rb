require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    output = []
    doc = Nokogiri::HTML(open(index_url))
    student = doc.css('div.card-text-container')

    student.each { |student|
      name = student.css('h4.student-name').text
      location = student.css('p.student-location').text
      url = student.parent.first[1]
      output << {
        :name => name,
        :location => location,
        :profile_url => url,
      }
    }

    output
  end

  def self.scrape_profile_page(profile_url)
    profile = {}
    twitter = nil
    linkedin = nil
    github = nil
    blog = nil

    doc = Nokogiri::HTML(open(profile_url))
    socials = doc.css('div.social-icon-container a')

    socials.each { |social|
      if social.attr('href').include?('twitter')
        twitter = social.attr('href')

      elsif social.attr('href').include?('linkedin')
        linkedin = social.attr('href')

      elsif social.attr('href').include?('github')
        github = social.attr('href')

      else
        blog = social.attr('href')
      end

    }

    profile_quote = doc.css('div.profile-quote').text
    bio = doc.css('div.bio-content .description-holder p').text

    profile = {
      :twitter => twitter,
      :linkedin => linkedin,
      :github => github,
      :blog => blog,
      :profile_quote => profile_quote,
      :bio => bio
    }.reject{|k,v| v.nil?}
  end

end

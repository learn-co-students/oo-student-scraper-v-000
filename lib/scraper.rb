require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)

    doc = Nokogiri::HTML(open(index_url))
    students = []

    doc.css('.roster-cards-container').each do |card|
      card.css('.student-card a').each do |s|
        url = s.attr('href')
        student_hash = {
          :name => s.css('.student-name').text,
          :location => s.css('.student-location').text,
          :profile_url => url
        }
      students << student_hash
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)

    doc = Nokogiri::HTML(open(profile_url))

    urls = doc.css('.social-icon-container a').collect do |social|
      social.attr('href')
    end # this returns array of social URLS

    blog = urls.reject {|u| u.include?("twitter") || u.include?("linkedin") || u.include?("github")}

    profile_hash = {
      :twitter => urls.detect {|u| u.include? "twitter"},
      :linkedin => urls.detect {|u| u.include? "linkedin"},
      :github => urls.detect {|u| u.include? "github"},
      :blog => blog[0],
      :profile_quote => doc.css('.profile-quote').text,
      :bio => doc.css('.description-holder p').text
    }
    
    profile_hash.each do |key, value|
      profile_hash.delete(key) if value == nil
    end
  end

end

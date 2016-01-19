require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './student.rb'

class Scraper
  attr_accessor :students

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students_hash=[]
    doc.css("div.student-card").each do |student_info|
      student_hash = {
        :name => student_info.css("h4.student-name").text,
        :location => student_info.css("p.student-location").text,
        :profile_url => "http://students.learn.co/"+student_info.css("a").attribute("href").value
      }
      students_hash << student_hash
    end

    students_hash
  end

  def self.scrape_profile_page(profile_url)
    profile_hash = {}

    doc = Nokogiri::HTML(open(profile_url))
    profile = doc.css("div.profile")
    socials = profile.css("div.vitals-container div.social-icon-container a")
    socials.each do |social|
      url = social.attribute("href").value
      social_network = url.sub(/https:\/\/www\.|https:\/\/|http:\/\/www\.|http:\/\//, "").split('.')[0]
      if social_network != ''
        if ['twitter', 'linkedin', 'github'].include?(social_network)
           profile_hash[social_network.to_sym] = url
        else
           profile_hash[:blog] = url
        end
      end
    end
    quote = profile.css("div.vitals-container div.vitals-text-container div.profile-quote").text
    profile_hash[:profile_quote]= quote
    bio = profile.css("div.details-container div.bio-block.details-block div.bio-content.content-holder div.description-holder p").text
    profile_hash[:bio] = bio

    profile_hash
  end

end

# chen = Scraper.scrape_profile_page("http://students.learn.co/students/mathieu-balez.html")
# binding.pry

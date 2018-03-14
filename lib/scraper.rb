require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)

    html = File.read(index_url)
    student_indexes = Nokogiri::HTML(html)

    #student_indexes: student_indexes.css("div.student-card")
    #name: student_index.css("h4.student-name").text
    #location: student_index.css("p.student-location").text
    #profile_url: student_index.css("a")[0]["href"]
    student_array = []
    student_indexes.css("div.student-card").each do |student|
      hash = {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => "./fixtures/student-site/" + student.css("a")[0]["href"]

      }
      student_array.push(hash)
    end
      #binding.pry
      student_array
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    student_profile = Nokogiri::HTML(html)

    #size: student_profile.css("div.social-icon-container a").size
    #twitter: student_profile.css("div.social-icon-container a")[0]["href"]
    #linkedin facebook github blog
    i = 0
#binding.pry
    hash = {}
    while i < student_profile.css("div.social-icon-container a").size do
      social_media = student_profile.css("div.social-icon-container a")[i]["href"].match(/(twitter|linkedin|facebook|github)/)
      key = (social_media ? social_media[0] :  "blog")
      hash[key.to_sym] = student_profile.css("div.social-icon-container a")[i]["href"]
      i += 1
    end
    hash[:profile_quote] = student_profile.css("div.profile-quote").text
    hash[:bio] = student_profile.css("div.description-holder p").text
    hash
  end

end

#Scraper.scrape_profile_page("fixtures/student-site/students/ryan-johnson.html")

require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    all_students = [ ]
    doc = Nokogiri::HTML(open(index_url))
    students = doc.css(".student-card")

    students.each do |student|
      all_students << {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.css("a").attribute("href").value}
    end

    all_students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    social_profiles = [ ]

    doc.css(".social-icon-container").css("a").each do |x|
      social_profiles << x.attribute("href").value
    end

    profile = {
      :twitter => social_profiles.detect{|x| x.include?("twitter")},
      :linkedin => social_profiles.detect{|x| x.include?("linkedin")},
      :github => social_profiles.detect{|x| x.include?("github")},
      :blog => social_profiles.detect{|x| !x.include?("github") && !x.include?("linkedin") && !x.include?("twitter")},
      :profile_quote => doc.css(".profile-quote").text.strip,
      :bio => doc.css(".bio-content.content-holder").css(".description-holder").text.strip
    }
    # remove all keys with nil values
    profile = profile.select{|k, v| !v.nil?}
  end

end

require 'open-uri'
require 'pry'
require 'nokogiri'
#students: doc.css("div.student-card")
#name: student.css("a div.card-text-container h4.student-name").text
#location: student.css("div.card-text-container p.student-location").text
#profile_url: student.css("a").attribute("href").value
#student profile page
#profile_name: student_profile.css("div.vitals-text-container h1.profile-name").text
#profile_location: student_profile.css("div.vitals-text-container h2.profile-location").text
#profile_quote: student_profile.css("div.vitals-text-container div.profile-quote").text
#profile_urls: student_profile.css("div.social-icon-container a") this is where all the social icons are. you may need to iterate over each perhaps.
#social_icon_container.css("a")
# student_profile.css("div.social-icon-container a").collect{ |icon| icon.attribute("href").value }

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)

    students = []

    doc.css("div.student-card").each do |student|
      students << {
        :name => student.css("a div.card-text-container h4.student-name").text,
        :location => student.css("div.card-text-container p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    student_profile = Nokogiri::HTML(html)

    url_array = student_profile.css("div.social-icon-container a").collect { |icon| icon.attribute("href").value }

    url_hash = {}

    url_array.each do |url|
      if url.include?("twitter")
        url_hash[:twitter] = url
      elsif url.include?("linkedin")
        url_hash[:linkedin] = url
      elsif url.include?("github")
        url_hash[:github] = url
      else
        url_hash[:blog] = url
      end
    end

    url_hash[:profile_quote] = student_profile.css("div.vitals-text-container div.profile-quote").text
    url_hash[:bio] = student_profile.css("div.description-holder p").text
    url_hash
  end

end

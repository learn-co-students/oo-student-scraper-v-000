require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.open(index_url)
    profiles = Nokogiri::HTML(html)
    students_array = []

    profiles.css("div.student-card").each do |student|
      student =
        {
          :name => student.css("h4.student-name").text,
          :location => student.css("p.student-location").text,
          :profile_url => student.css("a").attribute("href").value
        }
      students_array << student
    end
    students_array
    # students: profiles.css("div.student-card")
    # name: student.css("h4.student-name").text
    # location: student.css("p.student-location").text
    # profile_url: student.css("a").attribute("href").value
  end

  def self.scrape_profile_page(profile_url)
    html = File.open(profile_url)
    profile = Nokogiri::HTML(html)
    profile_details = {}

    profile_details[:profile_quote] = profile.css("div.profile-quote").text
    profile_details[:bio] = profile.css("div.bio-content.content-holder p").text

    links = profile.css("div.social-icon-container a").map do |link|
      link.attribute("href").value
    end

    links.each do |link|
      if link.include?("twitter")
        profile_details[:twitter] = link
      elsif link.include?("linkedin")
        profile_details[:linkedin] = link
      elsif link.include?("github")
        profile_details[:github] = link
      else
        profile_details[:blog] = link
      end
    end
    profile_details
    # links: profile.css("div.social-icon-container a")
    # profile_quote: profile.css("div.profile-quote").text
    # bio: profile.css("div.bio-content.content-holder p").text
  end
end

require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.open(index_url)
    profiles = Nokogiri::HTML(html)
    students = []

    profiles.css("div.student-card").each do |student|
      student =
        {
          :name => student.css("h4.student-name").text,
          :location => student.css("p.student-location").text,
          :profile_url => student.css("a").attribute("href").value
        }
      students << student
    end
    students
    # students: profiles.css("div.student-card")
    # name: student.css("h4.student-name").text
    # location: student.css("p.student-location").text
    # profile_url: student.css("a").attribute("href").value
  end

  def self.scrape_profile_page(profile_url)
    html = File.open(profile_url)
    profile = Nokogiri::HTML(html)
    profile_details = {}

    profile.css("body").each do |profile_detail|
      # how can I get the below to work with the same syntax as above? i.e. :profile_quote => profile_detail.css("div.profile-quote").text
      profile_details[:profile_quote] = profile_detail.css("div.profile-quote").text
      profile_details[:bio] = profile_detail.css("div.bio-content.content-holder p").text

      profile_detail.css("div.social-icon-container a").each do |link|
        if link.attribute("href").value.include?("twitter")
          profile_details[:twitter] = link.attribute("href").value
        elsif link.attribute("href").value.include?("linkedin")
          profile_details[:linkedin] = link.attribute("href").value
        elsif link.attribute("href").value.include?("github")
          profile_details[:github] = link.attribute("href").value
        elsif link.attribute("href").value.include?("http")
          profile_details[:blog] = link.attribute("href").value
        end
      end
    end
    profile_details
    # links: profile_detail.css("div.social-icon-container a")
    # profile_quote: profile_detail.css("div.profile-quote").text
    # bio: profile_detail.css("div.bio-content.content-holder p").text
  end
end

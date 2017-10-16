require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open("#{index_url}")
    student_site = Nokogiri::HTML(html)

    profiles = []
    profile = {}

    student_site.css("div.student-card").each do |project|
      profile = {
        :name => project.css("h4").text,
        :location => project.css("p.student-location").text,
        :profile_url => project.css("a").attribute("href").value
      }

      profiles << profile
    end
    profiles
  end

  def self.scrape_profile_page(profile_url)
    html = open("#{profile_url}")
    student_profile = Nokogiri::HTML(html)

    profile = {}

    student_profile.css("div.social-icon-container a").each do |a|
      if a.attribute("href").value.include?("twitter")
        profile[:twitter] = a.attribute("href").value
      elsif a.attribute("href").value.include?("linkedin")
        profile[:linkedin] = a.attribute("href").value
      elsif a.attribute("href").value.include?("github")
        profile[:github] = a.attribute("href").value
      else
        profile[:blog] = a.attribute("href").value
      end
    end
      profile[:profile_quote] = student_profile.css("div.profile-quote").text
      profile[:bio] = student_profile.css("div.bio-content p").text
      profile
  end

end

#Each Student
#profiles: student-card
#name ("div.student-card h4").text
#location
#profile_url

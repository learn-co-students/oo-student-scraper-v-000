require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = Nokogiri::HTML(open(index_url))
    students = []

    html.css("div.roster-cards-container div.student-card").each do |student|
      students << {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
    end
    students

  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    student_profile = {}

    social_links = profile_page.css("div.social-icon-container a").collect { |link| link['href']} #collect social links into array
    social_links.each do |link|
      student_profile[:twitter] = link if link.include?("twitter")
      student_profile[:linkedin] = link if link.include?("linkedin")
      student_profile[:github] = link if link.include?("github")
    end
    student_profile[:blog] = social_links[3] if social_links[3] #blog is usually the fourth link

    profile_quote = profile_page.css("div.profile-quote").text
    bio = profile_page.css("div.bio-content div.description-holder p").text
    student_profile[:profile_quote] = profile_quote if profile_quote
    student_profile[:bio] = bio if bio

    student_profile
  end

end

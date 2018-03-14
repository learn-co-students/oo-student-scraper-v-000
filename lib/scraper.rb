require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    index_page = Nokogiri::HTML(html)

    students = []
    index_page.css("div.student-card").collect do |student|
      new_student = {}
      new_student[:name] = student.css("h4.student-name").text
      new_student[:location] = student.css("p.student-location").text
      new_student[:profile_url] = student.css("a").attribute("href").value
      students << new_student
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)

    profile_page = Nokogiri::HTML(html)

    profile = {}
    profile_page.css("div.social-icon-container a").each do |social|
      link = social.attribute('href').value
      if link.include?("twitter")
        profile[:twitter] = link
      elsif link.include?("linkedin")
        profile[:linkedin] = link
      elsif link.include?("github")
        profile[:github] = link
      else
        profile[:blog] = link
      end
    end
    profile[:profile_quote] = profile_page.css(".vitals-text-container .profile-quote").text
    profile[:bio] = profile_page.css(".details-container .description-holder p").text
    profile
  end

end


require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    students = page.css(".student-card")

    student_array = []
    students.each do |student|
      s_name = student.css(".student-name").text
      s_location = student.css(".student-location").text
      s_profile = student.css("a").attribute("href").value
      student_array << {name: s_name, location: s_location, profile_url: s_profile}
    end
    student_array
  end

  # twitter url, linkedin url, github url, blog url, profile quote, and bio.

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    details = {}
    details[:bio] = page.css(".bio-content p").text
    details[:profile_quote] = page.css(".profile-quote").text

    socials = []
    social = page.css(".social-icon-container").children.select(&:element?)
    social.each{|s| socials << s.attribute("href").value}
    # socials.each do |s|
    #   details[:linkedin] = s if s.match('linkedin')
    #   details[:github] = s if s.match('github')
    #   details[:twitter] = s if s.match('twitter')
    # end

    social.each do |s|
      ss = s.attribute("href").value
      details[:linkedin] = ss if ss.match('linkedin')
      details[:github] = ss if ss.match('github')
      details[:twitter] = ss if ss.match('twitter')
      details[:blog] = ss if s.css("img").attribute('src').value == '../assets/img/rss-icon.png'
    end
    details
  end

end

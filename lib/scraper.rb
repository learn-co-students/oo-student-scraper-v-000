require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    site = Nokogiri::HTML(open(index_url))
    students = []
    site.css(".student-card").each do |student|
      student_info = {}
        student_info[:name] = student.css(".student-name").text
        student_info[:location] = student.css(".student-location").text
        unique_profile_url = student.css("a").attribute("href").value
        student_info[:profile_url] = index_url + unique_profile_url
      students << student_info
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    site = Nokogiri::HTML(open(profile_url))
    student_profile = {}

    twitter = site.css(".social-icon-container a[href*='twitter']")
    linkedin = site.css(".social-icon-container a[href*='linkedin']")
    github = site.css(".social-icon-container a[href*='github']")
    blog = site.css(".social-icon-container a:not([href*='twitter']):not([href*='linkedin']):not([href*='github'])")
    profile_quote = site.css(".profile-quote")
    bio = site.css(".bio-content .description-holder p")

    student_profile[:twitter] = twitter.attribute("href").value unless twitter.empty?
    student_profile[:linkedin] = linkedin.attribute("href").value unless linkedin.empty?
    student_profile[:github] = github.attribute("href").value unless github.empty?
    student_profile[:blog] = blog.attribute("href").value unless blog.empty?
    student_profile[:profile_quote] = profile_quote.text unless profile_quote.empty?
    student_profile[:bio] = bio.text unless bio.empty?
    student_profile
  end

end


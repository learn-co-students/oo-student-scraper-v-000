require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    sstudents = []

    doc = Nokogiri::HTML(open(index_url))
    students = doc.css(".student-card")

    students.each do |student|
      sstudents << { :name => student.css("h4").text,
        :location => student.css(".student-location").text,
        :profile_url => student.css("a").first["href"] }
    end

    sstudents
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    social_links = doc.css(".social-icon-container a").map { |link| link["href"] }
    social = ["twitter", "youtube", "facebook", "github", "linkedin"]

    twitter = social_links.select {|s| s.include?("twitter") }
    linkedin = social_links.select {|s| s.include?("linkedin") }
    github = social_links.select {|s| s.include?("github") }
    blog = social_links.select { |s| social.all? { |soc| !s.include? soc } }

    scraped = {}
    scraped[:twitter] = twitter.first unless twitter.empty?
    scraped[:linkedin] = linkedin.first unless linkedin.empty?
    scraped[:github] = github.first unless github.empty?
    scraped[:blog] = blog.first unless blog.empty?
    scraped[:profile_quote] = doc.css(".profile-quote").text
    scraped[:bio] = doc.css(".description-holder p").text
    scraped
  end

end

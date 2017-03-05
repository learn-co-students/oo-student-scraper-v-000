require 'open-uri'
require 'pry'

class Scraper

  # Scrapes the Learn student page for the names, locations and profile urls of each student
  # taken from their student card
  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))  # Nokogiri with Open-uri makes the http request to open the page
    scraped_students= []
    site = index_url.split("index.html")
    # For each student card collect the student names, locations and profile urls into
    # a hash for each student. Then place each individual hash into the students array
    page.css("div.student-card a").each do |student|
      scraped_students << {:name => student.css("h4").text,
        :location => student.css("p").text, :profile_url => site[0] + student.attribute("href").value}
    end
    scraped_students
  end

  # Scrapes a students profile page for their atttibutes:
  # Their twitter url, facebook url, github url, blog url, profile quote
  # and biography info.
  # Allows for a student not to have all the available social links on their profile
  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    social = page.css("div.social-icon-container a")
    student = {}
    array = []
    # Collect all the social links for the student
    array = social.collect { |a| a.attribute("href").value}
    # Checks which social links a student has and assigns a key and
    # value for their student hash
    array.each do |site|
      if site.include?("twitter")
        student[:twitter] = site
      elsif site.include?("linkedin")
        student[:linkedin] = site
      elsif site.include?("github")
        student[:github] = site
      else
        student[:blog] = site
      end
    end
    # Adds the key and value for the students profile quote and biography info
    student[:profile_quote] = page.css("div.profile-quote").text
    student[:bio] = page.css("div.description-holder p").text
    student
  end

end

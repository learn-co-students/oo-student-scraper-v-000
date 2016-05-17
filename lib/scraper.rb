require 'open-uri'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)

    html = open(index_url)
    doc = Nokogiri::HTML(html)

    doc.css(".student-card").map do |student|
      {
        name: student.css(".student-name").text,
        location: student.css(".student-location").text,
        profile_url: index_url + "/" + student.css("a").attribute("href").value
      }
    end

  end

  def self.scrape_profile_page(profile_url)

    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    twitter = doc.css(".social-icon-container a[href*='twitter']")
    linkedin = doc.css(".social-icon-container a[href*='linkedin']")
    github = doc.css(".social-icon-container a[href*='github']")
    blog = doc.css(".social-icon-container a:not([href*='twitter']):not([href*='linkedin']):not([href*='github'])")
    profile_quote = doc.css(".profile-quote")
    bio = doc.css(".bio-content .description-holder p")
    
    profile = {}

    profile[:twitter] = twitter.attribute("href").value unless twitter.empty?
    profile[:linkedin] = linkedin.attribute("href").value unless linkedin.empty?
    profile[:github] = github.attribute("href").value unless github.empty?
    profile[:blog] = blog.attribute("href").value unless blog.empty?
    profile[:profile_quote] = profile_quote.text unless profile_quote.empty?
    profile[:bio] = bio.text unless bio.empty?
    
    profile

  end

end
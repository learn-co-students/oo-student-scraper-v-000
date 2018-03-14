require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    
    doc.css(".student-card").each do |student|
      students << {
        name: student.css(".student-name").text,
        location: student.css(".student-location").text,
        profile_url: "./fixtures/student-site/#{student.css("a").attribute("href").value}"
      }
    end

    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    social_links = doc.css('.social-icon-container a')

    twitter = get_social_link(social_links, 'twitter')
    linkedin = get_social_link(social_links, 'linkedin')
    github = get_social_link(social_links, 'github')
    blog = get_social_link(social_links, 'rss')

    profile_quote = doc.css(".profile-quote").text
    bio = doc.css(".bio-content .description-holder p").text

    student = {
      :bio => bio,
      :profile_quote => profile_quote,
      :twitter => twitter,
      :linkedin => linkedin,
      :github => github,
      :blog => blog
    }

    student.select { |k,v| v != nil }
  end

  def self.get_social_link(social_links, social_network)
    link = social_links.detect do |link| 
      link.css('img').first['src'].include?(social_network)
    end

    link ? link['href'] : nil
  end

end

# Scraper.scrape_profile_page("http://students.learn.co/")
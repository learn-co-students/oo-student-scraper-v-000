require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    index = Nokogiri::HTML(html)

    students = []

    index.css("div.student-card").each do |student|
      students << {
        :location => student.css(".student-location").text,
        :name => student.css(".student-name").text,
        :profile_url => "http://students.learn.co/#{student.css("a").attr("href").value}"
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    index = Nokogiri::HTML(html)
    profile = {}
    index.css(".social-icon-container a").each do |link|
      profile[:twitter] = link.attribute("href").value if link.attribute("href").value.include?("twitter")
      profile[:linkedin] = link.attribute("href").value if link.attribute("href").value.include?("linkedin")
      profile[:github] = link.attribute("href").value if link.attribute("href").value.include?("github")
      profile[:blog] = link.attribute("href").value if link.css("img").attribute("src").text.include?("rss")
    end
    
    profile[:profile_quote] = index.css("div.profile-quote").text,
    profile[:bio] = index.css("div.description-holder p").text
    
    profile
  end

end


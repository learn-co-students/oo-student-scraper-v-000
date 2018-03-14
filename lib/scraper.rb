require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper


  def self.scrape_index_page(index_url)
    flatiron = Nokogiri::HTML(open(index_url))
      students = []

      flatiron.css(".student-card").each do |f|
        students << {
          :name => f.css("h4.student-name").text,
          :location => f.css("p.student-location").text,
          :profile_url => f.css("a").attribute("href").text.prepend("./fixtures/student-site/")
        }
      end
      students
  end


  def self.scrape_profile_page(profile_url)
    student = {}
    page = Nokogiri::HTML(open(profile_url))
      page.css(".social-icon-container a").each do |p|
        if p.attribute("href").text.include?("linkedin") then student[:linkedin] = p.attribute("href").text
        elsif p.attribute("href").text.include?("twitter") then student[:twitter] = p.attribute("href").text
        elsif p.attribute("href").text.include?("github") then student[:github] = p.attribute("href").text
        else student[:blog] = p.attribute("href").text
      end
    end
      student[:profile_quote] = page.css(".profile-quote").text
      student[:bio] = page.css("p").text
      student
  end
end

# iterate over .social-icon-container a
# linkedin: a.attribute("href").text
# github: a.attribute("href").text
# blog: a.attribute("href").text
# profile_quote: page.css(".profile-quote").text
# bio: page.css("p").text

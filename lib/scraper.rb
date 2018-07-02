require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper


  def self.scrape_index_page(index_url)
      html = open(index_url)
      doc = Nokogiri::HTML(html)
      students = []
      doc.css(".student-card").each do |student|
          students << {name: student.css(".student-name").text,
          location: student.css(".student-location").text,
          profile_url: student.css("a").attribute("href").value
      }
      end
      students
  end


  def self.scrape_profile_page(profile_url)
      doc = Nokogiri::HTML(open(profile_url))
      attributes = {}
      links = []
      doc.css(".social-icon-container a").each do |a|
          links << a.attribute("href").value
      end
      links.each do |link|
          if link.include?("twitter")
              attributes[:twitter] = link
          elsif link.include?("github")
              attributes[:github] = link
          elsif link.include?("linkedin")
              attributes[:linkedin] = link
          else attributes[:blog] = link
          end
      end
      attributes[:profile_quote]= doc.css(".profile-quote").text
      attributes[:bio]= doc.css(".description-holder p").text
      attributes
  end

end

# binding.pry

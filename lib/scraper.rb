require 'open-uri'
require 'pry'

class Scraper

# Returns an array of hashes with keys :name, :location, and :profile_url
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    list = doc.css(".student-card")
    list.each do |student|
        students << {:name => student.css(".student-name").text,
                   :location => student.css(".student-location").text,
                   :profile_url => "#{index_url}#{student.css("a").attribute("href").value}"

        }
      end
      students
  end
  # Take the url of a student profile page and scrape it for links, quote, and bio.
   # Return a hash, student_attributes, that has keys & values for each social link
   # found, as well as for :profile_quote and :bio.
  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student = {}
    links = doc.css(".social-icon-container a").map { |el| el.attribute('href').value}
    links.each do |link|
      if link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("twitter")
          student[:twitter] = link
      elsif link.include?("github")
        student[:github] = link
      else
        student[:blog] = link
      end
    end
    student[:profile_quote] = doc.css(".profile-quote").text if doc.css(".profile-quote")
    student[:bio] = doc.css("div.bio-content.content-holder div.description-holder p").text if doc.css("div.bio-content.content-holder div.description-holder p")
    student
  end
end

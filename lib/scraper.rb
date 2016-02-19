require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url) # the #open takes one arg, a URL, and returns the HTML content of the URL
    index_page = Nokogiri::HTML(html) # parses HTML and collects data for extraction returning a Node Set
    students = index_page.css(".student-card") # use css selectors to extract content

    student_data = students.collect do |student| # iterates over elements in [], assigns value of css selectors to key: {}
     { name: student.css(".student-name").text,
       location: student.css(".student-location").text,
       profile_url: "http://127.0.0.1:4000/#{student.css("a").attribute("href").text}"
     }
    end
    student_data
  end

  def self.scrape_profile_page(profile_url)
    scraped_student = {}
    links = []
    student = Nokogiri::HTML(open(profile_url))
    student.css("div.social-icon-container a").each do |link|
      links << link["href"]
      links.each do |link| # iterates over elements and evaluates if attribute value includes condition
        if link.include?("twitter")
          scraped_student[:twitter] = link
        elsif link.include?("linkedin")
          scraped_student[:linkedin] = link
        elsif link.include?("github")
          scraped_student[:github] = link
        else
          scraped_student[:blog] = link
        end
      end
    end
    scraped_student[:profile_quote] = student.css(".profile-quote").text
    scraped_student[:bio] = student.css("p").text
    scraped_student
  end

end

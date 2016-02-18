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
    html = open(profile_url)
    profile_page = Nokogiri::HTML(html)
    student = {}
    profile_page.css(".social-icon-container a").each do |icon| # iterates over elements and evaluates if attribute value includes condition
        url = icon.attribute("href").value
      if url.include? "twitter"
        student[:twitter] = url # assigns value to key: in student {}
      elsif url.include? "linkedin"
        student[:linkedin]= url
      elsif url.include? "github"
        student[:github] = url
      else
        student[:blog] = url
      end
    end
  end

end

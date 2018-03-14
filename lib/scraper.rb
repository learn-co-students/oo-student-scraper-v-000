require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    scraped = []
    doc = Nokogiri::HTML(open(index_url))

    students = doc.search(".student-card")
    students.each do |student|
      student_card = {}

      student_card[:name] = student.search("a .student-name").text
      student_card[:location] = student.search("a .student-location").text
      student_card[:profile_url] = student.search("a").attribute("href").text

      scraped << student_card
    end
    scraped
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    student = {}

    links = page.css('.social-icon-container a')
    links.each do |link|
      if test_link(link, "twitter")
        student[:twitter] = link["href"]
      elsif test_link(link, "linkedin")
        student[:linkedin] = link["href"]
      elsif test_link(link, "github")
        student[:github] = link["href"]
      else
        student[:blog] = link["href"]
      end
    end
    student[:profile_quote] = page.css(".profile-quote").text
    student[:bio] = page.css(".bio-block .description-holder p").text
    student
  end

  def self.test_link(link, value)
    !link["href"].scan(value).empty?
  end

end

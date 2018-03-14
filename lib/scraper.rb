require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = Nokogiri::HTML(open(index_url)).css(".student-card")
    students.collect do |student|
      {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => "./fixtures/student-site/#{student.css("a").attribute("href").value}"
      }
    end
  end

  def self.scrape_profile_page(profile_url)
    student = Nokogiri::HTML(open(profile_url))
    info = student.css(".social-icon-container a")
    scraped_student = {}
    info.collect do |l|
      link = l['href']
      key = ""
      if link.include?("twitter")
        key = :twitter
      elsif link.include?("github")
        key = :github
      elsif link.include?("linkedin")
        key = :linkedin
      else
        key = :blog
      end
      scraped_student[key] = link
    end
    scraped_student[:profile_quote] = student.css(".profile-quote").text
    scraped_student[:bio] = student.css(".description-holder p").text
    scraped_student

  end



end

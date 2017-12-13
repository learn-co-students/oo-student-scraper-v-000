require 'open-uri'
require 'pry'

class Scraper

  attr_accessor :scraped_students, :scraped_student, :twitter_url, :linkedin_url, :github_url
  @scraped_students = []
  @scraped_student = {}

  def self.scrape_index_page(index_url)
    html = open('./fixtures/student-site/index.html')
    doc = Nokogiri::HTML(html)
    students = doc.css("div.student-card")
    students.each do | student |
      @student_info = {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a")[0]["href"]
      }
      @scraped_students << @student_info
    end
    @scraped_students
  end

  def self.scrape_profile_page(profile_url)
    html = open("#{profile_url}")
    doc = Nokogiri::HTML(html)
    # binding.pry
    doc.css(".social-icon-container a").each do | link |
      @twitter_url = link["href"] if link["href"].include?('twitter')
      @linkedin_url = link["href"] if link["href"].include?('linkedin')
      @github_url = link["href"] if link["href"].include?('github')
    end
    @scraped_student = {
      :twitter => @twitter_url,
      :linkedin => @linkedin_url,
      :github => @github_url,
      :blog => doc.css(".social-icon-container a:last-of-type")[0]["href"],
      :profile_quote => doc.css(".profile-quote").text,
      :bio => doc.css(".description-holder p").text
    }
    binding.pry
  end

end

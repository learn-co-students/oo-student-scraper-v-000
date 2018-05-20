require 'open-uri'
require 'pry'

class Scraper

  attr_accessor :index_url, :profile_url

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    doc = Nokogiri::HTML(html)
    details = doc.css("div.student-card")
    scraped_students = []
    details.each do |student|
      scraped_students.push({
        :name => student.css("a div.card-text-container h4.student-name").text,
        :location => student.css("a div.card-text-container p.student-location").text,
        :profile_url => student.css("a").attr("href").value
        })
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    #profile_url = "./fixtures/student-site/students/joe-burgess.html"
    scraped_student = {}
    html = File.read(profile_url)
    doc = Nokogiri::HTML(html)
    details = doc.css("div.vitals-container")
    #binding.pry
    scraped_student[:student_joe_hash] = {
      :twitter => details.css("div.social-icon-container a").attr("href").value,
      :linkedin => details.css("div.social-icon-container a a").attr("href").value,
      :github => details.css("div.social-icon-container a a a").attr("href").value,
      :blog => details.css("div.social-icon-container a a a a").attr("href").value,
      :profile_quote => details.css("div.vital-text-container div.profile-quote").text,
      :bio => doc.css("div.details-container div.bio-block div.bio-content div.description-holder p").text
    }
  end

end

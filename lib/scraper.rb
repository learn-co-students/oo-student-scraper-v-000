require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_index = []
    students = doc.css(".student-card")
    students.each do |student|
      student_hash = {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => "./fixtures/student-site/#{student.css("a").attribute("href").value}"
      }
      student_index << student_hash
    end
    student_index
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))

    student = {
      :profile_quote => profile_page.css("div.profile-quote").text,
      :bio => profile_page.css("div.bio-content.content-holder div.description-holder p").text
    }

    social_links = profile_page.css("div.social-icon-container a")
    binding.pry
  end

end

require 'open-uri'
require 'pry'

class Scraper


  def self.scrape_index_page(index_url)
    index_url = "./fixtures/student-site/index.html"
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
    profile_url = "./fixtures/student-site/students/" + self.scrape_index_page(index_url)[3]
    binding.pry
  end

end

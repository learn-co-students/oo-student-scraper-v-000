require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open("./fixtures/student-site/index.html"))

    scraped_students = []
    student_hash = {}
    student_hash[:name] = doc.css(".student-card").css("h4").css(".student-name").map{|name| name.text}
    student_hash[:location] = doc.css(".student-card").css("p").css(".student-location").map{|location| location.text}
    student_hash[:profile_url] = doc.css(".student-card").css("a").map{|link| link.attribute('href').to_s}
    student_hash.map do |k,v|
      scraped_students << Student.new(student_hash).send("#{k}=",v)
    end
    scraped_students
    binding.pry
    # scraped_students
    # binding.pry
  end

  def self.scrape_profile_page(profile_url)

  end

end

require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    noko_doc = Nokogiri::HTML(open(index_url))

    students_array = []

    cards = noko_doc.css(".student-card")

    cards.each do |card|
      students_array << {
        :name => card.css("h4.student-name").text,
        :location => card.css("p.student-location").text,
        :profile_url => card.css("a").attribute("href").value
      }
    end
    students_array
  end

  # cards.first.css("h4.student-name").text - name

  # cards.first.css("a").attribute("href").value - profile_link

  # cards.first.css("p.student-location").text - location

  def self.scrape_profile_page(profile_url)
    noko_doc = Nokogiri::HTML(open(profile_url))
    binding.pry
    #pass in each 'a' and use its own name to make the key
    noko_doc.css(".social-icon-container a").each do |ele_a|
      ele_a.attribute("href").value.gsub




    student_info = {



    }
  end

end

Scraper.scrape_index_page("./fixtures/student-site/index.html")
Scraper.scrape_profile_page("./fixtures/student-site/students/aaron-enser.html")

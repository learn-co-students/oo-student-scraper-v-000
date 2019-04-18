require 'open-uri'
require 'pry'

class Scraper

# index_url = '.fixtures/student-site.index.html'
  def self.scrape_index_page(index_url)
    #html = File.read(index_url)
    index = Nokogiri::HTML(File.read(index_url))

    scraped_students = []
# [# {:name => "Abby Smith", :location => "Brooklyn, NY",
# :profile_url => "students/abby-smith.html"} ]

    index.css("div.roster-cards-container.student_card").each do |student_card|
      scraped_students << {
        :name => student_card.css("div.card-text-container h4.student_name").text,
        :location => student_card.css("div.card-text-container p.student-location").text,
        :profile_url => student_card.css("::before a").attribute("html").value
      }

    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)

  end
end

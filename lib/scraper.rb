require 'open-uri'
require 'nokogiri' #i added this
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read('fixtures/student-site/index.html')
    index_page = Nokogiri::HTML(html)

    projects = {}

    index_page.css(".student-card").each do |project|
      projects = {:name => project.css(".student-name").text,
      binding.pry
      } # => name => "Ryan Johnson"

   project.css(".student-location").text # =>location

    end

    #student-name

  end

  def self.scrape_profile_page(profile_url)

  end

end

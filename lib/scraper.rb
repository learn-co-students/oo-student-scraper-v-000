require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)

    doc = Nokogiri::HTML(open(index_url)) #grabs the HTML that
    #makes up index_url and then uses the Nokogiri::HTML method
    #to convert it to a NodeSet that we can use. Save it in doc.
    #binding.pry
    scraped_students = []
    doc.css(".student-card").each do|student|
      scraped_students <<{
      :name => student.css("h4").text, :location => student.css("p").text, :profile_url => student.css("a").attr("href").value
    }
    end
     scraped_students
    end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    profile_page = Nokogiri::HTML(html)

    profile_page = {}

    profile_page.css(".social-icon-container").each do |page|
      profile = project.css("a").attr("href").value
      profile_page[profile.to_sym] = {}
  end
end

end

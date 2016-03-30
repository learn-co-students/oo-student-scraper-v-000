require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open(index_url))

    doc.search("div.student-card").each do |student|
      
      students << {
        :name => student.search("h4.student-name").text,
        :location => student.search("p.student-location").text,
        :profile_url => "http://students.learn.co/" + student.search("a").attribute("href")
      }
    
    end
    students

  end


  def self.scrape_profile_page(profile_url)
    information = {}
    doc = Nokogiri::HTML(open(profile_url))
      doc.search(".social-icon-container a").each do |link|
        reference = link.attribute("href").value
      information[:twitter] = reference if reference.include?("twitter")
      information[:linkedin] = reference if reference.include?("linkedin")
      information[:github] = reference if reference.include?("github")
      information[:blog] = reference if link.search("img").attribute("src").text.include?("rss")
      information[:profile_quote] = doc.search("div.profile_quote").text
      information[:bio] = doc.search("div.description-holder p").text
      
     end
     information

  end

end


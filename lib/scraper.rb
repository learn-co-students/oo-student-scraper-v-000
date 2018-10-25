require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
      doc = Nokogiri::HTML(open(index_url))
      scraped_students = []
      doc.css("div.roster-cards-container").each do |student|
        name = doc.css("h4").text
        scraped_students[name.to_sym] = {
          :location => doc.css("p").text

        }
      end
      scraped_students
    end

  def self.scrape_profile_page(profile_url)

  end

end


#names doc.css("h4").text
#location doc.css("p").text
#kickstarter.css("li.project.grid_4").each do |project|
#   title = project.css("h2.bbcard_name strong a").text
#   projects[title.to_sym] = {
#     :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
#     :description => project.css("p.bbcard_blurb").text,
#     :location => project.css("ul.project-meta span.location-name").text,
#     :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
#   }
 #end

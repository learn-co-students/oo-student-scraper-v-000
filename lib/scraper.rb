require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read('fixtures/student-site/index.html')
    students = Nokogiri::HTML(html)
    student_hash = []
    binding.pry
    students.css('div.roster-cards-container.student-card').each do |individual_students|
        binding.pry
    end
  end

end


# html = File.read('fixtures/kickstarter.html')
# kickstarter = Nokogiri::HTML(html)
#
# projects = {}
#
#iterate through all the projects on page
    # projects: kickstarter.css("li.project.grid_4")
# kickstarter.css("li.project.grid_4").each do |project|
#   title = project.css("h2.bbcard_name strong a").text
#   projects[title.to_sym] = {
#     :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
#     :description => project.css("p.bbcard_blurb").text,
#     :location => project.css("ul.project-meta span.location-name").text,
#     :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
#   }

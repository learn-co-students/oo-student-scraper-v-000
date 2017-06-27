require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read('fixtures/student-site/index.html')
    scraper = Nokogiri::HTML(html)
    students_array = []
    student_hash = {}
    scraper.css('.roster-cards-container').each do |card|
      students_array = [student_hash = {:name => ("a > div.card-text-container > h4"),
        :location => ("a > div.card-text-container > p"),
        :profile_url => ("a > div.view-profile-div > h3")}]

  end

  # def create_project_hash
  #   html = File.read('fixtures/kickstarter.html')
  #   kickstarter = Nokogiri::HTML(html)
  #
  #   projects = {}
  #
  #   kickstarter.css("li.project.grid_4").each do |project|
  #     # this should be the selector here #=> #projects_list > li:nth-child(1) > div > div
  #     title = project.css("h2.bbcard_name strong a").text
  #     projects[title.to_sym] = {
  #       :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
  #       :description => project.css("p.bbcard_blurb").text,
  #       :location => project.css("ul.project-meta span.location-name").text,
  #       :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
  #     }
  #     #binding.pry
  #   end


  def self.scrape_profile_page(profile_url)

  end

end

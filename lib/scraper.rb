require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read('fixtures/student_site/index.html')
    kickstarter = Nokogiri::HTML(html)
    student_list = []
    
      doc.css("div.student_card a").each do |student|
        student_list <<
        {:name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.attribute("href").value}
      end
    student_list
    binding.pry
  end
  

  def self.scrape_profile_page(profile_url)
    
  end

end

page = Scraper.new
page.scrape_index_page('fixtures/student_site/index.html')

# projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text
# image link: project.css("div.project-thumbnail a img").attribute("src").value
# description: project.css("p.bbcard_blurb").text
# location: project.css("ul.project-meta span.location-name").text
# percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i

=begin
def create_project_hash
  # write your code here
  html = File.read('fixtures/kickstarter.html')
  doc = Nokogiri::HTML(html)
  projects = {}
  
  kickstarter.css("li.project.grid_4").each do |project|
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta span.location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  end
  
  projects
end
create_project_hash
=end
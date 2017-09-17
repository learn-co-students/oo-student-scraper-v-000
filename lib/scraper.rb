require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(index_url)

    projects = []

    index_page.css("li.project.grid_4").each do |project|
      title = project.css("h2.bbcard_name strong a").text
      projects[title.to_sym] = {
        :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
        :description => project.css("p.bbcard_blurb").text,
        :location => project.css("ul.project-meta span.location-name").text,
        :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
      }
    end

    # return the projects hash
    projects
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(profile_url)

    projects = {}

    profile_page.css("li.project.grid_4").each do |project|
      title = project.css("h2.bbcard_name strong a").text
      projects[title.to_sym] = {
        :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
        :description => project.css("p.bbcard_blurb").text,
        :location => project.css("ul.project-meta span.location-name").text,
        :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
      }
    end

    # return the projects hash
    projects
  end

end

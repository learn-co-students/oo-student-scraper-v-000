

require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper

    def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
    end

    def get_page
      # The .get_page instance method will be responsible
      # for using Nokogiri and open-uri to grab the entire HTML document from the web page.
      doc = Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))

      # doc.css(".post").each do |post|
      #   course = Course.new
      #   course.title = post.css("h2").text
      #   course.schedule = post.css(".date").text
      #   course.description = post.css("p").text
      # end
    end

    def get_courses
      # The #get_courses instance method will be responsible for using a CSS selector
      #to grab all of the HTML elements that contain a course. In other words, the return
      #value of this method should be a collection of Nokogiri XML elements, each of which
      #describes a course offering. We're going to have to examine the page with the element
      #inspector to find the CSS selector that contains the courses.
      self.get_page.css(".post:not(.empty-event)")
    end


    def make_courses
      #The #make_courses method will be responsible for actually instantiating Course objects
      # and giving each course object the correct title, schedule and description attribute
      #that we scraped from the page.
      self.get_courses.each do |post|
         course = Course.new
         course.title = post.css("h2").text
         course.schedule = post.css(".date").text
         course.description = post.css("p").text
      end
    end

end

Scraper.new.get_page

Scraper.new.print_courses


def create_project_hash
  html = File.read('fixtures/kickstarter.html')

  kickstarter = Nokogiri::HTML(html)

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

  # projects: kickstarter.css("li.project.grid_4")
  # title: project.css("h2.bbcard_name strong a").text
  # image link: project.css("div.project-thumbnail a img").attribute("src").value
  # description: project.css("p.bbcard_blurb").text
  # location: project.css("ul.project-meta span.location-name").text
  # percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
end

create_project_hash

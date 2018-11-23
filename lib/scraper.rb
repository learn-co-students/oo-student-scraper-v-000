require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []

    index_page.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        students << {
        name: student.css(".student-name").text,
        location: student.css(".student-location").text,
        profile_url: "#{student.attr('href')}"
        }
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    student = []

    profile_page.css(".social-icon-container").children.css("a").collect do |element| #takes the social icon container, and iterates through its children
      links = element.attribute('href').value #collects element attributes that match href and returns the value.
      links.each do |link|
        if link.include?("twitter")
          student[twitter_url:] = link
        elsif link.include?("linkedin")
          student[linkedin_url:] = link
        elsif link.include?("github")
          student[github_url:] = link
        elsif link.include?("blog")
          student[blog_url:] = link
        end
      end
    end
student[profile_quote:] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")
student[bio:] = profile_page.css("div.bio-content.content-holder div.description-holder p").text if profile_page.css("div.bio-content.content-holder div.description-holder p")

student
  end
end

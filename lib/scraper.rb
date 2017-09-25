require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read('fixtures/student-site/index.html')
    index_html = Nokogiri::HTML(open(index_url))

    students = []

    index_html.css("div.roster-cards-container").each do |roster|
      roster.css("div.student-card a").each do |student|
        student_profile_link = student.attr("href")
        student_name = student.css("h4.student-name").text
        student_location = student.css("p.student-location").text
      students << {profile_url: student_profile_link, name: student_name, location: student_location}
          end
    end
    students
  end



  def self.scrape_profile_page(profile_url)
    student = {}
    profile_page = Nokogiri::HTML(open(profile_url))
    links = profile_page.css("div.social-icon-container").children.css("a").map {|social| social.attribute("href").value}
    links.each do |link|
      if link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include?("twitter")
        student[:twitter] = link
      else
        student[:blog] = link
      end
    end
    student[:profile_quote] = profile_page.css("div.profile-quote").text
    student[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text

  student
  end

end

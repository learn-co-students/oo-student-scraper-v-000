require 'open-uri'
require 'nokogiri'
require 'pry'


class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))# "./fixtures/student-site/index.html"
    students = []
    doc.css("div.roster-cards-container").each do |c|
      c.css(".student-card a").each do |student|
        student = {
         :profile_url => student.attr('href'),
         :name => student.css(".student-name").text,
         :location => student.css(".student-location").text
       }
       students<<student
       end
     end
    students

  end

  def self.scrape_profile_page(profile_url)#  #students/fname-lname.html      ./fixtures/student-site/students
    doc = Nokogiri::HTML(open(profile_url))
    student = {}
    links = doc.css(".social-icon-container").children.css("a").map {|child| child.attr("href")}.each do |link|
         if link.include?("twitter")
            student[:twitter] = link
         elsif link.include?("linkedin")
            student[:linkedin] = link
         elsif link.include?("github")
            student[:github] = link
         else
           student[:blog] = link
        end
      end
      student[:profile_quote] = doc.css(".profile-quote").text
      student[:bio] = doc.css(".description-holder p").text
      student
  end
end

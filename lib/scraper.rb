require 'open-uri'
require 'pry'

class Scraper
  attr_accessor :name, :location, :profile_url

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
      doc.css(".student-card").collect do |student|
        students << {
          :name => student.css(".student-name").text,
          :location => student.css(".student-location").text,
          :profile_url => student.css("a").attr('href').value
        }
      end
      students
     end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student = {}
    doc.css(".social-icon-container a").each do |link|
          link = link.attribute("href").value
          if link.include?("linkedin")
            student[:linkedin] = link
          elsif link.include?("twitter")
            student[:twitter] = link
          elsif link.include?("github")
            student[:github] = link
          else link.include?("blog")
            student[:blog] = link
          end
        end
      student[:profile_quote] = doc.css("div.profile-quote").text
      student[:bio] = doc.css("div.bio-content.content-holder div.description-holder p").text
      student
    end
  end

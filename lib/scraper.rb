require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_html = open(index_url)
    index = Nokogiri::HTML(index_html)
    student = index.css(".student-card")
    students = []
    student.collect do |student_card|
      # binding.pry
      students << {
        :name => student_card.css("h4.student-name").text,
        :location => student_card.css("p.student-location").text,
        :profile_url => student_card.css("a").attribute("href").value
        }
  end
  students
  end

  def self.scrape_profile_page(profile_url)
    student_html = open(profile_url)
    student_index = Nokogiri::HTML(student_html)
    student_info = {}
    student_index.css("div.social-icon-container a").each do |student_page|
      case student_page.attribute("href").value
      when /twitter/
        student_info[:twitter] = student_page.attribute("href").value
      when /github/
        student_info[:github] = student_page.attribute("href").value
      when /linkedin/
        student_info[:linkedin] = student_page.attribute("href").value
      else
          student_info[:blog] = student_page.attribute("href").value
      end
    end
    student_info[:profile_quote] = student_index.css("div.profile-quote").text
    student_info[:bio] = student_index.css("div.bio-content div.description-holder").text.strip
    student_info
    end


end

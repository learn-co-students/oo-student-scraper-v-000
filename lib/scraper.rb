require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    index_page = Nokogiri::HTML(open("#{index_url}"))
    index_page.css(".student-card").each do |student|
      students << {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => "./fixtures/student-site/#{student.css("a").attribute("href").value}"
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    student_info = {}
    profile_page = Nokogiri::HTML(open("#{profile_url}"))
    student_info[:profile_quote] = profile_page.css(".profile-quote").text
    student_info[:bio] = profile_page.css(".bio-block .description-holder p").text
    links = profile_page.css(".social-icon-container a").map {|icon| icon.attribute("href").value}
    links.each do |link|
      if link.include?("twitter")
        student_info[:twitter] = link
      elsif link.include?("linkedin")
        student_info[:linkedin] = link
      elsif link.include?("github")
        student_info[:github] = link
      else
        student_info[:blog] = link
      end
    end
    student_info

  end

end

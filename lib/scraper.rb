require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    html = File.read('./fixtures/student-site/index.html')
    student_cards = Nokogiri::HTML(html)
    
    student_cards.css("div.student-card").each do |student|
      add_student = {
        :name => student.css("h4.student-name").children.to_s,
        :location => student.css("p.student-location").children.to_s,
        :profile_url => student.css("a").attribute("href").value
      }
      students << add_student
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    student_page = Nokogiri::HTML(html)
    socials = student_page.css("div.social-icon-container").css("a")
    student = {}

    socials.each do |social|
      if social.attribute("href").value.include?("twitter")
        student[:twitter] = social.attribute("href").value
        elsif social.attribute("href").value.include?("linkedin")
        student[:linkedin] = social.attribute("href").value
        elsif social.attribute("href").value.include?("github")
        student[:github] = social.attribute("href").value
        else
        student[:blog] = social.attribute("href").value
      end
    end
    
    student[:profile_quote] = student_page.css("div.profile-quote").children.to_s
    student[:bio] = student_page.css("div.description-holder").css("p").children.to_s
    student
  end

end


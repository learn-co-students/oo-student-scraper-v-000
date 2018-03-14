require 'open-uri'
require 'pry'
require 'nokogiri'
class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    index_page = Nokogiri::HTML(html)
    students = []
    index_page.css("div.roster-cards-container").each do |student_cards|
      student_cards.css("div.student-card").each do |student|
        name = student.css("h4.student-name").text
        location = student.css("p.student-location").text
        profile_url =  student.css("a").attr("href").value
        data = {
          :name => name,
          :location => location,
          :profile_url => profile_url
        }
        students << data
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    student_page = Nokogiri::HTML(html)
    student = {}
    student[:profile_quote] = student_page.css("div.profile-quote").text
    student[:bio] = student_page.css("div.description-holder p").text
    student_page.css("div.social-icon-container a").each do |link|
      if link.css('img').attr('src').value.include?("twitter")
        student[:twitter] = link.attr('href')
      elsif link.css('img').attr('src').value.include?("github")
        student[:github] = link.attr('href')
      elsif link.css('img').attr('src').value.include?("rss")
        student[:blog] = link.attr('href')
      elsif link.css('img').attr('src').value.include?("linkedin")
        student[:linkedin] = link.attr('href')
      end
    end
    student
  end

end

require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    roster = Nokogiri::HTML(html)

    students = []
    roster.css(".student-card").each do |student|
      students << {
        :name => student.css("a .card-text-container .student-name").text,
        :location => student.css("a .card-text-container .student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    document = Nokogiri::HTML(html)

    student = {}

    student[:bio] = document.css('p').text
    student[:profile_quote] = document.css('.profile-quote').text

    document.css('.social-icon-container a').each do |social|
      link = social.attributes["href"].value
        if link.include?("github")
        student[:github] = link
      elsif link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("twitter")
      student[:twitter] = link
      elsif !link.include?("twitter") && !link.include?("linkedin") && !link.include?("github")
        student[:blog] = link
      end
    end
    student
    end
  end

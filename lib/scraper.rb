require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    roster = Nokogiri::HTML(File.read(index_url))

    students = []

    roster.css(".student-card").each do |student|
      students << {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => "./fixtures/student-site/#{student.css("a").attribute("href").value}"
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(File.read(profile_url))

    student = {
      :profile_quote => profile.css(".profile-quote").text,
      :bio => profile.css("div.description-holder p").text
    }

    social = profile.css(".social-icon-container a").collect {|a| a['href']}
    social.each do |link|
      if link.include? "twitter.com"
        student[:twitter] = link
      elsif link.include? "linkedin.com"
        student[:linkedin] = link
      elsif link.include? "github.com"
        student[:github] = link
      else
        student[:blog] = link
      end
    end
    student
  end

end

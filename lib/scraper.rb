require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    learn_student_page = Nokogiri::HTML(open(index_url))

    student_array = []
    learn_student_page.css("div.student-card").each do |student|
      student = {
      :name => student.css("h4").text,
      :location => student.css("p").text,
      :profile_url => './fixtures/student-site/' + student.css("a").attribute("href").value
      }
      student_array << student
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    learn_profile_page = Nokogiri::HTML(open(profile_url))
    student = {
      :profile_quote => learn_profile_page.css("div.profile-quote").text,
      :bio => learn_profile_page.css("div.bio-content.content-holder div.description-holder p").text
    }
    social_media_links = learn_profile_page.css("div.social-icon-container a").map { |link| link['href'] }
    social_media_links.each do |link|
      if link.include?("twitter.com")
        student[:twitter] = link
      elsif link.include?("linkedin.com")
        student[:linkedin] = link
      elsif link.include?("github.com")
        student[:github] = link
      else
        student[:blog] = link
      end
    end
    student
  end
end

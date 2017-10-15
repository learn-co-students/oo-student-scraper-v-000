require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_doc = doc.css("div.student-card")

    students = []

    student_doc.each do |s|
 #binding.pry
      student = {
        :name => s.css("h4.student-name").text,
        :location => s.css("p.student-location").text,
       :profile_url => "#{s.css("a").attribute("href").value}"#./fixtures/
      }
      students << student
    end

    students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))

    profile = {}

    links = profile_page.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}
    links.each do |link|
      if link.include?("linkedin")
        profile[:linkedin] = link
      elsif link.include?("github")
        profile[:github] = link
      elsif link.include?("twitter")
        profile[:twitter] = link
      else
        profile[:blog] = link
      end
    end

    profile[:profile_quote] = "#{profile_page.css("div.profile-quote").text}"
    profile[:bio] = "#{profile_page .css("div.details-container div.description-holder p").text}"
    profile
  end
end

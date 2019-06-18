require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    students = []
    page.css(".student-card").each do |student|
      students << {
        :name => student.css("a .card-text-container h4.student-name").text,
        :location => student.css("a .card-text-container p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))

    student_info = {
      :profile_quote => page.css(".profile-quote").text,
      :bio => page.css(".bio-content .description-holder p").text
    }

    social_links = page.css(".social-icon-container a")
    social_links.each do |anchor|
      icon = anchor.css("img").attribute("src").value
      url = anchor.attribute("href").value
      if icon.include?("twitter")
        student_info[:twitter] = url
      elsif icon.include?("github")
        student_info[:github] = url
      elsif icon.include?("linkedin")
        student_info[:linkedin] = url
      elsif icon.include?("rss")
        student_info[:blog] = url
      end
    end

    student_info
  end
end


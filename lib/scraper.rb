require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index = Nokogiri::HTML(open(index_url))
    students = []

    index.css(".student-card").each do |student|
      location = student.css(".student-location").text
      name = student.css("h4.student-name").text
      profile_url = "./fixtures/student-site/#{student.css("a").attr('href').text}"

      students << {
        name: name,
        location: location,
        profile_url: profile_url
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    student_page = Nokogiri::HTML(open(profile_url))
    student = Hash.new

    student_page.css(".social-icon-container a").each do |site|
      if site.attr("href").include?("twitter")
        student[:twitter] = site.attr("href")
      elsif site.attr("href").include?("linkedin")
        student[:linkedin] = site.attr("href")
      elsif site.attr("href").include?("github")
        student[:github] = site.attr("href")
      else
        student[:blog] = site.attr("href")
      end
    end
    student[:profile_quote] = student_page.css(".vitals-container .vitals-text-container .profile-quote").text
    student[:bio] = student_page.css(".details-container .bio-block .description-holder p").text
    student
  end

end

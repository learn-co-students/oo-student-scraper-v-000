require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper



  def self.scrape_index_page(index_url)
    html = open(index_url)
    scraped_students = []
    doc = Nokogiri::HTML(html)
    students_from_index = doc.css(".student-card")
    students_from_index.each do |student|
      scraped_students << {
        name: student.css("h4.student-name").text,
        location: student.css("p.student-location").text,
        profile_url: student.css("a").attr("href").value
      }
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    scraped_student = {}
    doc = Nokogiri::HTML(html)
    student_social_media = doc.css(".vitals-container .social-icon-container a")
    student_social_media.each do |social|
      if social.css("img").attr("src").value.include?("twitter")
        scraped_student[:twitter] = social.attr("href")
      end
      if social.css("img").attr("src").value.include?("linkedin")
        scraped_student[:linkedin] = social.attr("href")
      end
      if social.css("img").attr("src").value.include?("github")
        scraped_student[:github] = social.attr("href")
      end
      if social.css("img").attr("src").value.include?("youtube")
        scraped_student[:youtube] = social.attr("href")
      end
      if social.css("img").attr("src").value.include?("rss")
        scraped_student[:blog] = social.attr("href")
      end
    end
    scraped_student[:profile_quote] = doc.css(".profile-quote").text.strip
    scraped_student[:bio] = doc.css(".bio-content .description-holder").text.strip
    scraped_student
  end

end

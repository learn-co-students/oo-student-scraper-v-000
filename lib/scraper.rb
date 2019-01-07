require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.search(".student-card").each do |student|
      students << {:name => student.css(".student-name").text, :location => student.css("p.student-location").text, :profile_url => student.css("a").attr("href").value}
      end
      students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    student_hash = {:profile_quote => doc.css(".profile-quote").text,
      :bio => doc.css(".description-holder p").text}

      social_links = doc.css(".social-icon-container a")

      social_links.each do |lk|
        links = lk.attr('href')
        case
        when links.include?("twitter")
          student_hash[:twitter] = links
        when links.include?("linkedin")
          student_hash[:linkedin] = links
        when links.include?("github")
          student_hash[:github] = links
        else
          student_hash[:blog] = links
        end
      end
      student_hash
  end

end

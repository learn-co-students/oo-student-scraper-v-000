require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

    # attr_accessor :name, :location

  def self.scrape_index_page(index_url)
      html = open(index_url)
      doc = Nokogiri::HTML(html)
      students_list = doc.css(".roster-cards-container .student-card")
        student_index_array = []
    students_list.each do |student|
        student_index_array  << {
            name: student.css(".student-name").text,
            location: student.css(".student-location").text,
            profile_url: student.css("a").first["href"]
            }
    end
    student_index_array
  end

  def self.scrape_profile_page(profile_url)
      html = open(profile_url)
      doc = Nokogiri::HTML(html)

      profile_page = doc.css(".main-wrapper")
      scraped_student = {}




        links = profile_page.css(".social-icon-container a").map do |links|
          links["href"]
        end

        links.each do |link|

            key_strip = URI.parse(link).host.gsub(".com", "")
            key_strip_2 = key_strip.gsub("www.", "")# "linkedin"

            if key_strip_2 == "linkedin" || key_strip_2 == "twitter" ||  key_strip_2 == "github"
                scraped_student.merge!(key_strip_2.to_sym => link) #:linkedin => "https://www.linkedin.com/in/jmburges"
            else
                 scraped_student.merge!(blog: link)
            end
        end

        profile_page.each do |info|

          scraped_student.merge!(profile_quote: info.css(".profile-quote").text.gsub('\"', "'"))

          scraped_student.merge!(bio: info.css(".description-holder p").text.gsub("\n", " ").squeeze(' '))

        end
        scraped_student


  end


end

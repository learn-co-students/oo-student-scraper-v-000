require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open(index_url))
    student_card = doc.css(".student-card")

    student_card.each do |student|
      students << {
        :name => "#{student.css(".student-name").text}",
        :location => "#{student.css(".student-location").text}",
        :profile_url => "#{student.css("a").first['href']}"
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    info = {}
    doc = Nokogiri::HTML(open(profile_url))

    doc.css(".social-icon-container a").each do |word|
      link = word['href']
      if link.include? "twitter"
        info[:twitter] = "#{link}"
      elsif link.include? "linkedin"
        info[:linkedin] = "#{link}"
      elsif link.include? "github"
        info[:github] = "#{link}"
      elsif link.include? doc.css("vitals-text-container h1 profile-name").text
        info[:blog] = "#{link}"
      end
    end

    info[:profile_quote] = "#{doc.css(".profile-quote").text}"
    info[:bio] = "#{doc.css(".bio-content").css(".description-holder").css("p").text}"

    info
  end

end

require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []

    Nokogiri::HTML(File.read('fixtures/student-site/index.html')).css(".student-card").each do |student|
      students << {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => "./fixtures/student-site/" + student.css("a").attribute("href").value
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile = {}      
    doc = Nokogiri::HTML(File.read(profile_url))
    
    doc.css(".social-icon-container").css("a").each do |link|
    
        if link.attribute("href").value.include?("twitter")
          profile.merge!(twitter: link.attribute("href").value)
        elsif link.attribute("href").value.include?("linkedin")
          profile.merge!(linkedin: link.attribute("href").value)
        elsif link.attribute("href").value.include?("github")
          profile.merge!(github: link.attribute("href").value)
        else
          profile.merge!(blog: link.attribute("href").value)
        end

    end

    profile.merge!(profile_quote: doc.css(".profile-quote").text)
    profile.merge!(bio: doc.css(".bio-content div p").text)

    profile
  end

end


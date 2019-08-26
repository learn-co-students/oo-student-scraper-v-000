require 'open-uri'
require 'pry'
#==============================================
class Scraper
  def self.scrape_index_page(url)
    doc = Nokogiri::HTML(open(url))
    students = doc.css(".student-card")
    
    students.map do |student|
      { name: student.css(".student-name").text,
      location: student.css(".student-location").text,
      profile_url: student.css("a").first["href"] }
    end
  end
#==============================================
  def self.scrape_profile_page(url)
    doc = Nokogiri::HTML(open(url))
    attrs = {}
    social = doc.css(".social-icon-container a")
    
    social.each do |link|
      case link["href"]
      when (/^.*twitter.*/)
        attrs[:twitter] = link["href"]
      when (/^.*linkedin.*/)
        attrs[:linkedin] = link["href"]
      when (/^.*github.*/)
        attrs[:github] = link["href"]
      else attrs[:blog] = link["href"]
      end
    end
    attrs[:profile_quote] = doc.css(".profile-quote").text
    attrs[:bio] = doc.css(".description-holder p").text
    attrs
  end
#==============================================
end

















# def self.scrape_index_page(url)
#   doc = Nokogiri::HTML(open(url))
#   roster = doc.css("div.student-card")
#   roster.map do |student|N
#     # binding.pry
#       name: student.css(".student-name").text
#       location: student.css(".student-location").text
#       profile_url: student.css("a").first["href"]
#   end
  
#   student.css("a")
# end

require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
     doc = Nokogiri::HTML(open(index_url))

     students_array = []

     doc.css(".student-card").each do |student|
       students_array << { :name => student.css(".student-name").text,
       :location => student.css(".student-location").text,
       :profile_url => student.css("a").attribute("href").value }
     end

     students_array

  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    hash = {}

    doc.css(".social-icon-container").first.children.css("a").each do |url|
      if url.attribute("href").value.include?("twitter")
        hash[:twitter] = url.attribute("href").value
      elsif url.attribute("href").value.include?("linkedin")
        hash[:linkedin] = url.attribute("href").value
      elsif url.attribute("href").value.include?("github")
        hash[:github] = url.attribute("href").value
      else
        hash[:blog] = url.attribute("href").value
      end
    end
    hash[:profile_quote] = doc.css("div .profile-quote").text
    # binding.pry
    hash[:bio] = doc.css(".description-holder p").text
    hash
  end

end

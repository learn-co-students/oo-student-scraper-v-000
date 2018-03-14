require 'open-uri'
require 'nokogiri'
require 'pry'



class Scraper

  def self.scrape_index_page(index_url)
  doc = Nokogiri::HTML(open(index_url))
  student_hash = []
  doc.css(".student-card").each do |page|
    url = page.css("a").attribute("href").value
    name = page.css("h4").text
    location = page.css("p.student-location").text
    student_hash << {name: name, location: location, profile_url: url}
    end
    student_hash
    end



  def self.scrape_profile_page(profile_url)

    doc = Nokogiri::HTML(open(profile_url))
    student_hash = {}

    social_links = doc.css("div.social-icon-container").children.css("a").collect {|x| x.attribute("href").value}

    social_links.each do |link|
      if link.include?("twitter")
        student_hash[:twitter] = link
      elsif link.include?("linkedin")
        student_hash[:linkedin] = link
      elsif link.include?("github")
        student_hash[:github] = link
      else
        student_hash[:blog] = link
        end
      end
      student_hash[:bio] = doc.css("div.bio-content.content-holder div.description-holder p").text
      student_hash[:profile_quote] = doc.css("div.profile-quote").text
      student_hash
    end

end

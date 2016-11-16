require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_array = []
    doc = Nokogiri::HTML(open(index_url))

    doc.css(".student-card a").each do |x|
      student_hash = Hash.new
      student_hash[:name] = x.css("h4.student-name").text
      student_hash[:location] = x.css("p.student-location").text
      student_hash[:profile_url] = "./fixtures/student-site/#{x.attribute("href")}"
      student_array << student_hash
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    student_hash = Hash.new
    doc = Nokogiri::HTML(open(profile_url))
    #now i want to iterate through the actual links. do they contain twitter? etc. if they do, set up the key/values in hash
    links = doc.css("div.social-icon-container a").collect {|x| x.attribute("href").value}


    links.each do |link|
      case
      when link.include?("twitter")
        student_hash[:twitter] = link
      when link.include?("linkedin")
        student_hash[:linkedin] = link
      when link.include?("github")
        student_hash[:github] = link
      else
        student_hash[:blog] = link
      end
      student_hash[:profile_quote] = doc.css(".profile-quote").text
      student_hash[:bio] = doc.css(".bio-block .description-holder p").text
    end
    student_hash
  end

end

Scraper.scrape_profile_page("./fixtures/student-site/students/aaron-enser.html")

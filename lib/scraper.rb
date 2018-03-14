require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student = doc.css(".student-card")
    student.collect do |students|
      student_hash = {:name => students.css("h4.student-name").text, :location => students.css("p.student-location").text, :profile_url => students.search("a").attribute("href").text }
    end

  end

  def self.scrape_profile_page(profile_url) #returns hash describing student
    doc = Nokogiri::HTML(open(profile_url))
    individual_student_hash = Hash.new
    personal = doc.css("body")
    #if there is no html corresponding to social media handle, then don't include that key/value pair
    if personal.css("a[href*=twitter]").any?
    individual_student_hash[:twitter] = personal.search("a[href*=twitter]")[0]["href"]
    end

    if personal.css("a[href*=linkedin]").any?
    individual_student_hash[:linkedin] = personal.search("a[href*=linkedin]")[0]["href"]
    end

    if personal.css("a[href*=github]").any?
    individual_student_hash[:github] = personal.search("a[href*=github]")[0]["href"]
    end

    if personal.css("a[href$='com/']").any?
    individual_student_hash[:blog] = personal.search("a[href$='com/']")[0]["href"]
    end
    #individual_student_hash[:blog] = personal.search(".social-icon-container a:last-child").attribute("href").text

    individual_student_hash[:profile_quote] = personal.search(".vitals-text-container")[0].css("h2 + div").text
    individual_student_hash[:bio] = personal.css(".details-container p").text
    individual_student_hash.reject {|k,v| v == nil}

  end


end

require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_arr = []
    doc.css(".roster-cards-container").each do |card|
      card.css(".student-card").each do |student|
        name =  student.css("a div.card-text-container h4.student-name").text
        location = student.css("a div.card-text-container p.student-location").text
        profile = student.css("a").attribute("href").value
        student_arr << {:name => name, :location => location, :profile_url => "http://127.0.0.1:4000/#{profile}"}
      end
    end
    student_arr
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    pro_arr = doc.css(".social-icon-container a").map {|link| link.attribute("href").value }
    profile = {
      :profile_quote => doc.css(".vitals-text-container .profile-quote").text,
      :bio => doc.css(".bio-content .description-holder p").text
      }
    pro_arr.each do |link|
      if link.include?("twitter")
        profile[:twitter] = link
      elsif link.include?("linkedin")
        profile[:linkedin] = link
      elsif link.include?("github")
        profile[:github] = link
      else
        profile[:blog] = link
      end
    end
    profile
  end

end


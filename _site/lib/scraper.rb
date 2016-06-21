require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    index = Nokogiri::HTML(open(index_url))

    students_arr = []

    index.css(".roster-cards-container .student-card").collect do |student|
      hash = {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => "http://159.203.117.55:6891/" + student.css("a").attr("href").value
      }
      students_arr << hash
    end

    students_arr
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    hash = {}
    social_links = page.css(".social-icon-container a")
    social_links.each do |link|
      hash[:twitter] = link.attr("href") if link.attr("href").include?("twitter")
      hash[:linkedin] = link.attr("href") if link.attr("href").include?("linkedin")
      hash[:github] = link.attr("href") if link.attr("href").include?("github")
      #need to truncate the blog link to remove the http://
      hash[:blog] = link.attr("href") unless link.attr("href").include?("twitter") || link.attr("href").include?("linkedin") || link.attr("href").include?("github")

    end
    hash[:blog] = hash[:blog].delete!("http://") + "/" unless hash[:blog].nil?
    hash[:bio] = page.css(".description-holder p").text
    hash[:profile_quote] = page.css(".profile-quote").text
    #binding.pry
    hash
  end

end

require 'open-uri'
require 'pry'
require 'nokogiri'
require 'open-uri'




class Scraper



  def self.scrape_index_page(index_url)
    all = []

    doc = Nokogiri::HTML(open(index_url))

    students = doc.css(".roster-cards-container .student-card")
    students.collect do |student|
      {
        :name => student.css("h4.student-name").text,
   		  :location => student.css("p.student-location").text,
   		  :profile_url => student.css("a").attribute("href").value
      }
    end

    #binding.pry

  end#self.scrape_index_page

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student = {}
    student[:profile_quote] = doc.css("div.profile-quote").text
    student[:bio] = doc.css("div.description-holder p").text

    doc.css("div.social-icon-container a").each do |link|
      if link.attr('href').include?("twitter")
        student[:twitter] = link.attr('href')
      elsif link.attr('href').include?("linkedin")
        student[:linkedin] = link.attr('href')
      elsif link.attr('href').include?("github")
        student[:github] = link.attr('href')
      else
        student[:blog] = link.attr('href')
      end
    end
    student

  end

end #class

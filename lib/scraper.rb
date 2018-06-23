require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_array = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    student_list = doc.css(".student-card")
    student_list.each do |student|
      student_hash = {}
        student_hash[:name] = student.css("h4").text
        student_hash[:location] = student.css("p").text
        student_hash[:profile_url] = student.css("a").attribute("href").value

      student_array << student_hash
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    student_links = doc.css(".social-icon-container a")
    #binding.pry
    student_hash = {}
    student_links.each do |link|
      if link.attribute("href").value.include?("twitter")
        student_hash[:twitter] = link.attribute("href").value
      elsif link.attribute("href").value.include?("linkedin")
        student_hash[:linkedin] = link.attribute("href").value
      elsif link.attribute("href").value.include?("github")
        student_hash[:github] = link.attribute("href").value
      else
        student_hash[:blog] = link.attribute("href").value
      end
      #binding.pry
    end

    student_hash[:profile_quote] = doc.css(".profile-quote").text
    student_hash[:bio] = doc.css(".details-container p").text
    student_hash
    #binding.pry
  #  :twitter=>"https://twitter.com/jmburges",
  #                            :linkedin=>"https://www.linkedin.com/in/jmburges",
  #                            :github=>"https://github.com/jmburges",
  #                            :blog=>"http://joemburgess.com/",
  #                            :profile_quote=>"\"Reduce to a previously solved problem\"",
  #                            :bio=>
  end

end

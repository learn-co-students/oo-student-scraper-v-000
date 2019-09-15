require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    array_index = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card").each_with_index do |student, i|
      array_index[i]= {}
      array_index[i][:name] = student.css(".student-name").text
      array_index[i][:location] = student.css(".student-location").text
      array_index[i][:profile_url] = student.css("a").attr('href').value
    end
    array_index
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_hash = {}
    doc.css(".social-icon-container a").each do |a|
      if a.attr('href').include?("twitter")
        student_hash[:twitter] = a.attr('href')
      elsif a.attr('href').include?("linkedin")
        student_hash[:linkedin] = a.attr('href')
      elsif a.attr('href').include?("github")
        student_hash[:github] = a.attr('href')
      elsif a.attr('href').include?(".com")
        student_hash[:blog] = a.attr('href')
      end
    end
    # student_hash[:linkedin] = doc.css(".social-icon-container").detect do |a|
    #    a.css("a").attr('href').value.include?("linkedin")
    # end
    # student_hash[:github] = doc.css(".social-icon-container").detect do |a|
    #    a.css("a").attr('href').value.include?("github")
    # end
    student_hash[:profile_quote] = doc.css(".profile-quote").text
    student_hash[:bio] = doc.css(".description-holder p").text
    student_hash
  end

end

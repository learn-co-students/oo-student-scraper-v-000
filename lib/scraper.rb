require 'open-uri'
require 'pry'

class Scraper
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    return_array_of_hash = []
    students = doc.css(".student-card")

    students.each do |student|
      new_student_hash = {}
      new_student_hash[:name] = student.css("h4").text
      new_student_hash[:location] = student.css("p").text
      new_student_hash[:profile_url] = student.css("a").attribute("href").value

      return_array_of_hash << new_student_hash
    end

    return_array_of_hash
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    return_hash = {}

    social_container = doc.css(".social-icon-container").children.css("a")

    social_container.each do |placeholder|

      social_url = placeholder.attribute("href").value

      if social_url.include?("twitter")
        return_hash[:twitter] = social_url
      elsif social_url.include?("linkedin")
        return_hash[:linkedin] = social_url
      elsif social_url.include?("github")
        return_hash[:github] = social_url
      else
        return_hash[:blog] = social_url
      end
    end

    return_hash[:profile_quote] = doc.css(".profile-quote").text
    return_hash[:bio] = doc.css("p").text

    return_hash
  end
end

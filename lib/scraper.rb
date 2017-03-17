require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students_array = []

    html = open(index_url)
    doc = Nokogiri::HTML(html)

    student_names = doc.css(".student-name")
    student_names.each do |element|
      students_array << {name: element.text}
    end


    student_loc = doc.css(".student-location")
    i = 0
    student_loc.each do |element|
      students_array[i][:location] = element.text
      i += 1
    end

    student_profile = doc.css(".student-card a")
    i = 0
    student_profile.each do |element|
      students_array[i][:profile_url] = "./fixtures/student-site/#{element["href"]}"
      i += 1
    end

    students_array
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    attributes_hash = {}

    attributes_hash[:profile_quote] = doc.search(".profile-quote").text
    attributes_hash[:bio] = doc.search(".bio-content p").text

    social_links = doc.css(".social-icon-container a")
    social_links.each do |element|
      link = element['href']
      if /twitter/.match(link)
        attributes_hash[:twitter] =  link
      elsif /linkedin/.match(link)
        attributes_hash[:linkedin] =  link
      elsif /github/.match(link)
        attributes_hash[:github] =  link
      else
        attributes_hash[:blog] =  link
      end
    end

    attributes_hash
  end

end

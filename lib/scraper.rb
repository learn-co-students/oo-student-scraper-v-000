require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)

    @students = []

    student_names = doc.css(".student-name")
      student_names.each do |name|
        @students << {name: name.text}
      end

    student_locations = doc.css(".student-location")
    i = 0
      student_locations.each do |location|
        @students[i][:location] = location.text
        i += 1
      end

    student_profiles = doc.css(".student-card a")
    i = 0
      student_profiles.each do |profile|
        @students[i][:profile_url] = "./fixtures/student-site/#{profile["href"]}"
        i += 1
      end
    @students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    student_profiles = {}

    student_profiles[:profile_quote] = doc.search(".profile-quote").text
    student_profiles[:bio] = doc.search(".description-holder p").text

    social_links = doc.css(".social-icon-container a")
      social_links.each do |element|
      link = element['href']
      if /twitter/.match(link)
        student_profiles[:twitter] = link
      elsif /linkedin/.match(link)
        student_profiles[:linkedin] = link
      elsif /github/.match(link)
        student_profiles[:github] = link
      else
        student_profiles[:blog] = link
      end
    end
    student_profiles
  end

end

# binding.pry
# self.scrape_index_page(index_url)

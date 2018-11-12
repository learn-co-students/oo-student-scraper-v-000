require 'open-uri'
require 'pry'
require 'nokogiri' #=> I added this one
require 'rubygems' #=> I added this one
class Scraper

  def self.scrape_index_page(index_url)
    students = []
    html = open(index_url)
    list = Nokogiri::HTML(html)

    names = list.css(".student-name")
    student_names = []
    names.each do |element|
      student_names << element.text
    end

    locations = list.css(".student-location")
    student_locations = []
    locations.each do |element|
      student_locations << element.text
    end

    sites = list.css(".student-card a[href]")
    student_sites = []
    sites.select do |element|
      student_sites << element['href']
    end

    index = 0
    student_names.each do |name|
      students << {:name => name, :location => student_locations[index], :profile_url => student_sites[index]}
      index += 1
    end
    students
  end

  def self.scrape_profile_page(profile_url)
      html = Nokogiri::HTML(open(profile_url))
      student = {}

      social_profile_links =html.css(".social-icon-container a").collect{|icon| icon.attribute("href").value}
      social_profile_links.each do |link|
        if link.include?("twitter")
          student[:twitter] = link
        elsif link.include?("linkedin")
          student[:linkedin] = link
        elsif link.include?("github")
          student[:github] = link
        elsif link.include?(".com")
          student[:blog] = link
        end
      end
      student[:profile_quote] = html.css(".profile-quote").text
      student[:bio] = html.css("div.description-holder p").text
      student
  end

end

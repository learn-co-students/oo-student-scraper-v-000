require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)

    all_students = doc.css(".roster-cards-container")
    all_students_array = []

    all_students.each do |x|
      x.css(".student-card a").each do |individual|
        name = individual.css(".card-text-container .student-name").text
        location = individual.css(".card-text-container .student-location").text
        profile_url = "http://127.0.0.1:4000/#{individual.attr("href")}"
        all_students_array << {name: name, location: location, profile_url: profile_url}
      end
    end
    all_students_array
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    for_links = doc.css(".vitals-container")
    profile_hash = {}

    links_array = for_links.css(".social-icon-container a").map { |x| x.attribute('href').value}
      links_array.each do |x|
      if x.include?("linkedin")
        profile_hash[:linkedin] = x
      elsif x.include?("github")
        profile_hash[:github] = x
      elsif x.include?("twitter")
        profile_hash[:twitter] = x
      else
        profile_hash[:blog] = x
      end
    end
    profile_hash[:profile_quote] = doc.css(".vitals-container .vitals-text-container .profile-quote").first.children.text
    profile_hash[:bio] = doc.css(".details-container .bio-block.details-block .bio-content.content-holder .description-holder p").text
    
    profile_hash
  end

end
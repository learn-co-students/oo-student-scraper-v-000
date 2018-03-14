require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css("div.roster-cards-container").each do |student|
      student.css("div.student-card a").each do |stud|
      name = stud.css(".student-name").text
      location = stud.css(".student-location").text
      profile_url = stud.attr("href")
      students << {:name => name, :location => location, :profile_url => profile_url}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    sites = {}
    doc = Nokogiri::HTML(open(profile_url))
    sites[:profile_quote] = doc.css("div.profile-quote").text
    sites[:bio] = doc.css("div.bio-content").last.css("p").text
    doc.css("div.social-icon-container a").each do |info| #   doc.css(".social-icon-container a").each do |site|
      if info.attribute("href").value.include?("twitter")
        sites[:twitter] = info.attribute("href").value
      elsif info.attribute("href").value.include?("linkedin")
        sites[:linkedin] = info.attribute("href").value
      elsif info.attribute("href").value.include?("github")
        sites[:github] = info.attribute("href").value
      else
        sites[:blog] = info.attribute("href").value
      end
    end  #site.attribute("href").value
    sites
  end
end

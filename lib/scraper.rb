require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  # students: learn.css("div.student-card")
  # name: student.css("div.card-text-container h4.student-name").text
  # location: student.css("div.card-text-container p.student-location").text
  # profile_url: student.css("a").attribute("href").value

  def self.scrape_index_page(index_url)
    learn = Nokogiri::HTML(open(index_url))

    students = []

    learn.css("div.student-card").each do |student|
      student_hash = {}
      student_hash[:name] = student.css("div.card-text-container h4.student-name").text
      student_hash[:location] = student.css("div.card-text-container p.student-location").text
      student_hash[:profile_url] = "#{index_url}/#{student.css("a").attribute("href").value}"
      students << student_hash
    end
    students
  end

  # twitter: profile_page.css("div.social-icon-container a").detect {|element| element.attribute("href").value.include?("twitter")}.attribute("href").value
  # linkedin: profile_page.css("div.social-icon-container a").detect {|element| element.attribute("href").value.include?("linkedin")}.attribute("href").value
  # github: profile_page.css("div.social-icon-container a").detect {|element| element.attribute("href").value.include?("github")}.attribute("href").value
  # blog: profile_page.css("div.social-icon-container a img.social-icon").detect {|element| element.attribute("src").value.include?("rss-icon")}.parent.attribute("href").value
  # profile_quote: profile_page.css("div.vitals-text-container div.profile-quote").text
  # bio: profile_page.css("div.bio-content.content-holder div.description-holder p").text

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    student = {}

    profile_page.css("div.social-icon-container a").each do |element|
      student[:"#{element.attribute("href").value[/(?<=:\/\/).*(?=\.com)/].gsub("www.","")}"] = element.attribute("href").value
    end

    if student.detect {|k,v| k != :twitter && k != :linkedin && k != :github}
      student[:blog] = student.detect {|k,v| k != :twitter && k != :linkedin && k != :github}[1]
    end

    student.delete_if {|k,v| k != :twitter && k != :linkedin && k != :github && k!= :blog}

    student[:profile_quote] = profile_page.css("div.vitals-text-container div.profile-quote").text
    student[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text
    student
  end

end

# Scraper.scrape_index_page("http://students.learn.co")
# Scraper.scrape_profile_page("http://students.learn.co/students/joe-burgess.html")


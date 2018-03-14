require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_list = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = doc.css(".student-card a")
    students.each do |student|
      name = student.css(".student-name").text
      location = student.css(".student-location").text
      # profile_url = student.attribute("href").value
      profile_url = "./fixtures/student-site/#{student.attribute("href").value}"
      student_list << {:name => name, :location => location, :profile_url => profile_url}
    end
    student_list
  end

  def self.scrape_profile_page(profile_url)
    hash = {}
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    doc.css(".social-icon-container a").each do |a|
      if a.css("img").attribute("src").value == "../assets/img/twitter-icon.png"
        hash[:twitter] = a.attribute("href").value
      elsif a.css("img").attribute("src").value == "../assets/img/linkedin-icon.png"
        hash[:linkedin] = a.attribute("href").value
      elsif a.css("img").attribute("src").value == "../assets/img/github-icon.png"
        hash[:github] = a.attribute("href").value
      elsif a.css("img").attribute("src").value == "../assets/img/rss-icon.png"
        hash[:blog] = a.attribute("href").value
      end
    end
    hash[:bio] = doc.css(".description-holder p").text
    hash[:profile_quote] = doc.css(".profile-quote").text
    hash
  end

end

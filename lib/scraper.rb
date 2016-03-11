require 'open-uri'
require 'pry'
# require 'nokogiri' (needs to be activated when scraping HTML page)

class Scraper

  # student_card: page.css(".student-card a")
  # name: page.css(".student-name").first.text
  # location: page.css(".student-location").first.text
  # profile_url: page.css(".student-card a").attribute("href").value
  ## profile_url (refactored): page.css(".student-card a").first["href"]
    # <a href="students/ryan-johnson.html"></a>
    # Note: the 'a' tag has an 'href' attribute whose value is "students/ryan-johnson.html"

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    students = []

    page.css("div.student-card a").each do |student|
      # url = "http://127.0.0.1:4000/#{student.attribute("href").value}"
      url = "http://127.0.0.1:4000/#{student["href"]}"
      name = student.css(".student-name").text
      location = student.css(".student-location").text
      students << {name: name, location: location, profile_url: url}
    end
    students
  end

  # twitter = page.css(".social-icon-container a").first["href"]
  # linkedin = page.css(".social-icon-container a")[1]["href"]
  # github = page.css(".social-icon-container a")[2]["href"]
  # blog = page.css(".social-icon-container a")[3]["href"]
  # profile_quote = page.css(".profile-quote").text
  # bio = page.css(".description-holder p").text

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    student_hash = {}

    page.css(".social-icon-container a").each do |link|
      if link["href"].include?("twitter")
        student_hash[:twitter] = link["href"]
      elsif link["href"].include?("linkedin")
        student_hash[:linkedin] = link["href"]
      elsif link["href"].include?("github")
        student_hash[:github] = link["href"]
      else
        student_hash[:blog] = link["href"]
      end
    end
    student_hash[:profile_quote] = page.css(".profile-quote").text if page.css(".profile-quote")
    student_hash[:bio] = page.css(".description-holder p").text if page.css(".description-holder p")

    student_hash
  end
end

# Scraper.scrape_index_page("http://127.0.0.1:4000/")
# Scraper.scrape_profile_page("http://127.0.0.1:4000/students/ryan-johnson.html")
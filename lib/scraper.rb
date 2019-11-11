require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"))

    students = []

    page = doc.css("div.roster-cards-container")
    page.each do |student_card|
      student_card.css(".student-card a").each do |student|
      name = student.css(".student-name").text
      location = student.css(".student-location").text
      profile_url = "#{student.attr('href')}"

      students << {:name => name, :location => location, :profile_url => profile_url}

      end
    end
  students
  end



  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    bio = doc.css(".description-holder")[0].text
  binding.pry
  end

end
Scraper.scrape_profile_page("https://learn-co-curriculum.github.io/student-scraper-test-page/students/ryan-johnson.html")


# student names: doc.css(".student-name").text.strip  #whitespace removed with .strip
# location: location = doc.css(".student-location").text.strip
# profile_url = "#{student.attr('href')}"

# twitter:
# linkedin:
# github:
# blog:
# profile_quote: profile_quote = doc.css(".profile-quote").text
# bio: doc.css(".description-holder")[0].text

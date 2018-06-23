require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  attr_accessor :name, :location, :profile_url, :linkedin, :github, :bio, :blog, :profile_quote

  def self.scrape_index_page(index_url)

      doc = Nokogiri::HTML(open("fixtures/student-site/index.html"))

      binding.pry
      #  student = Student.new

        #doc.css(".student-card").first
        #doc.css(".student-card").first.css("h4").text
        #doc.css(".student-card").first.css("p").text
      #  doc.css(".student-card").css("a").attribute("href").value

      student_array = []

  doc.css("div.roster-cards-container").each do |card|
    card.css(".student-card a").each do |student|
      profile_url = "#{student.attr("href")}"
      location = student.css(".student-location").text
      name = student.css(".student-name").text

    students = {
      name: name,
      location: location,
      profile_url: profile_url
    }
    student_array << students
  end
end
  student_array
  end

  def self.scrape_profile_page(profile_url)
  hash = {}
  doc = Nokogiri::HTML(open(profile_url))
  links = doc.css(".social-icon-container").children.css("a")
  each_link = links.collect {|link| link.attribute('href').value}

  quote = doc.css(".profile-quote").text
  bio = doc.css("p").text
each_link.collect do |link|
 if link.include? ("twitter")
  hash[:twitter] = link
elsif link.include?("github")
  hash[:github] = link
elsif link.include?("linkedin")
  hash[:linkedin] = link
else
  hash[:blog] = link
  end
end

#  hash[:blog] = each_link[3]
  hash[:profile_quote] = quote
  hash[:bio] = bio
#  hash[:linkedin] = each_link[1]

    hash


end

end

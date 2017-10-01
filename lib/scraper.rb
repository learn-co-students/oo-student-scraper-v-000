require 'open-uri'
require 'pry'
require 'nokogiri'
class Scraper

  def self.scrape_index_page(index_url)
    html = File.read('fixtures/student-site/index.html')
    doc = Nokogiri::HTML(html)
    students = {}

    doc.css("div.student-card").each do |student|
      name = student.css("div.card-text-container h4.student-name").text
      students[name.to_sym] = {
        :name => student.css("div.card-text-container h4.student-name").text,
        :location => student.css("div.card-text-container p.student-location").text,
        :profile_url => student.css("a").map { |link| link ['href']}.join
      }
      binding.pry
    #responsible for scraping the index page that lists all of the students and the
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    self.scrape_index_page(index_url)
    html = File.read('profile_url')
    doc = Nokogiri::HTML(html)
    name = doc.css("div.vitals-text-container h1.profile-name").each do |student|
      name = student.css("div.card-text-container h4.student-name").text
    profile_url = students[name][:profile_url]


    social_media = {}

    doc.css("div.social-icon-container a").map { |link| link ['href']}.join


    #responsible for scraping an individual student's profile page to get further information about that student
  end

end
binding.pry
self.scrape_index_page(index_url)

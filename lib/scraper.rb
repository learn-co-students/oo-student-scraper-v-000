require 'open-uri'
require 'pry'
require 'nokogiri'
class Scraper

  @@students = []

  def self.scrape_index_page(index_url)
    html = File.read('fixtures/student-site/index.html')
    doc = Nokogiri::HTML(html)

    doc.css("div.student-card").each do |student|
      @@students << {
        :name => student.css("div.card-text-container h4.student-name").text,
        :location => student.css("div.card-text-container p.student-location").text,
        :profile_url => student.css("a").map { |link| link ['href']}.join
      }
    #responsible for scraping the index page that lists all of the students and the
    end
    @@students
  end

  def self.students
    @@students
  end

  def self.scrape_profile_page(profile_url)
      html = File.read(profile_url)
      doc = Nokogiri::HTML(html)
      social_media = {
        :twitter => doc.css("div.social-icon-container a").map { |link| link ['href']}.first.join,
        :linkedin => doc.css("div.social-icon-container a").map { |link| link ['href']}[1],
        :github => doc.css("div.social-icon-container a").map { |link| link ['href']}.last.join,
        :profile_quote => doc.css("div.profile_quote").text,
        :bio => doc.css(div.description-holder).text
    }

    # def social_media
    #   if student.css("div.social-icon-container a").map { |link| link ['href']}.include? "github"
    #
    #   end
    # end


  end
    #   name = doc.css("div.vitals-text-container
    #  h1.profile-name").each do |student|
    #   name = student.css("div.card-text-container h4.student-name").text




    # doc.css("div.social-icon-container a").map { |link| link ['href']}.join


    #responsible for scraping an individual student's profile page to get further information about that student
  
end
binding.pry
self.scrape_profile_page(profile_url)
#
# self.students.each do |student|
#   html = File.read(student[:profile_url])
#   doc = Nokogiri::HTML(html)
#   social_media = {
#   :twitter => student.css("div.social-icon-container a").map { |link| link ['href']}.first.join,
#   :linkedin => "hi",
#   :github => "hi",
#   :blog => "hi",
#   :profile_quote => doc.css("div.profile_quote").text,
#   :bio => doc.css(div.description-holder).text

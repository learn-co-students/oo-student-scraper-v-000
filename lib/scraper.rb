require 'open-uri'
require 'pry'
#name = doc.css(".student-card").css("h4").text
#location = doc.css(".student-card").css("p").text
class Scraper

  def self.scrape_index_page(index_url)

    html = File.read(index_url)
    doc = Nokogiri::HTML(html)
    students = {}
    students_a = []

    doc.css("div .student-card").each do |student|
    students = {
      :name => student.css("h4").text,
      :location => student.css("p").text,
      :profile_url => student.css('a').first['href']
      }
      students_a << students
  end
      students_a
  end

  def self.scrape_profile_page(profile_url)
    
    html = File.read(profile_url)
    doc = Nokogiri::HTML(html)
    social_media = doc.css('div .social-icon-container').css('a') 
    profile = {
      :twitter => social_media.map { |link| link.attribute('href').value.scan(/[\S]+twitter[\S]+/)}.join(""),
      :linkedin => social_media.map { |link| link.attribute('href').value.scan(/[\S]+linkedin[\S]+/)}.join(""),
      :github => social_media.map { |link| link.attribute('href').value.scan(/[\S]+github[\S]+/)}.join(""),
      :blog => social_media.map { |link| link.attribute('href').value.scan(/https?:..[^twg][\S]+/)}.join(""),
      :profile_quote => doc.css('div.profile-quote').text,
      :bio => doc.css('div.description-holder p').text
        }
        
    end
    profile.delete_if{|k, v| v.empty?}
  #binding.pry
   end

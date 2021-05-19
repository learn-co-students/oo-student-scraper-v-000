require 'open-uri'
require 'pry'
require 'nokogiri'

# students : students_page.css('div.student-card')
# student_name : student.css('h4.student_name').text
# location : student.css("p.student-location").text
# profile_url : student.css("a").attribute("href").value

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    students_page = Nokogiri::HTML(html)

    students_array = []
    students = {}

    students_page.css('div.student-card').each { |student|
      students = {
        :name => student.css('h4.student-name').text,
        :location => student.css('p.student-location').text,
        :profile_url => student.css('a').first['href']
      }
      students_array << students
    }

    students_array
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    profile_page = Nokogiri::HTML(html)
    social = profile_page.css('div.social-icon-container').css('a')

    student_attr = {
      :twitter => social.map { |x| x.attribute('href').value.scan(/[\S]+twitter[\S]+/)}.join(""),
      :linkedin => social.map { |x| x.attribute('href').value.scan(/[\S]+linkedin[\S]+/)}.join(""),
      :github => social.map { |x| x.attribute('href').value.scan(/[\S]+github[\S]+/)}.join(""),
      :blog => social.map { |x| x.attribute('href').value.scan(/https?:..[^twg][\S]+/)}.join(""),
      :profile_quote => profile_page.css('div.profile-quote').text,
      :bio => profile_page.css('div.description-holder p').text
    }

    student_attr.delete_if { |key, val| val.to_s.strip.empty? }

  end

end

# binding.pry

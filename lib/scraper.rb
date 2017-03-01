require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card").each do |student|
      person = Hash.new
      person[:name] = student.css("h4").text
      person[:location] = student.css("p").text
      person[:profile_url] = "./fixtures/student-site/#{student.css("a").attr("href").text}"
      students << person
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    student_info = Hash.new
    accounts = ["twitter", "linkedin", "github", "blog"]
    doc = Nokogiri::HTML(open(profile_url))
    doc.css(".social-icon-container").css("a").each do |link|
      link_string = "#{link.attr("href")}"
      accounts.each { |e| link_string.include?(e) ? student_info[e.to_sym] = link.attr("href") : next }
    end
    genius = doc.css(".social-icon-container").css("a").last.attr("href")
    student_info[:blog] = genius if !student_info.values.include?(genius)
    student_info[:profile_quote] = doc.css(".profile-quote").text
    student_info[:bio] = doc.css(".description-holder").first.text.strip
    student_info
  end

end
# student_info = Hash.new
#
# doc = Nokogiri::HTML(open("http://159.203.84.80:30022/fixtures/student-site/students/laura-correa.html"))
# doc.css(".social-icon-container").css("a").each do |link|
#   accounts = ["twitter", "linkedin", "github", "blog"]
#   link_string = "#{link.attr("href")}"
#   accounts.each { |e| link_string.include?(e) ? student_info[e.to_sym] = link.attr("href") : next }
# end

#social meida link = doc.css(".social-icon-container").css("a").first.attr("href")

# index_url = "http://159.203.84.80:30024/fixtures/student-site/"
# students = []
# doc = Nokogiri::HTML(open(index_url))
# puts doc.css(".student-card").first.css("a").attr("href")
# binding.pry
# location doc.css(".student-card").first.css("p").text
# name = doc.css(".student-card").first.css("h4").text
# url = doc.css(".student-card").first.css("a").attr("href").text

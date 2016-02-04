require 'open-uri'
require 'nokogiri'
require 'pry'


class Scraper

  def self.scrape_index_page(index_url)

    doc = Nokogiri::HTML(open(index_url))

    scraped_students = []

    doc.css(".student-card").each do |student|
      student_info = {}

      student_info[:name] = student.css("h4").text
      student_info[:location] = student.css("p").text
      student_info[:profile_url] = "http://students.learn.co/#{student.css("a")[0]["href"]}"
      scraped_students << student_info
    end
    scraped_students
  end


  def self.scrape_profile_page(profile_url)
    begin
      doc = Nokogiri::HTML(open(profile_url))

      student_info = {}

      social = doc.css("div.vitals-container a")

      social.each {|x| student_info[:twitter] = x.attribute("href").value if x.to_s.match(/twitter/)}
      social.each {|x| student_info[:linkedin] = x.attribute("href").value if x.to_s.match(/linkedin/)}
      social.each {|x| student_info[:github] = x.attribute("href").value if x.to_s.match(/github/)}
      social.each {|x| student_info[:blog] = x.attribute("href").value if x.to_s.match(/rss/)}
      #adds quote
      student_info[:profile_quote] = doc.css("div.profile-quote").text
      #adds bio
      student_info[:bio] = doc.css("div.bio-content p").text
    rescue OpenURI::HTTPError => e
      puts "couldn't find #{profile_url}"
      student_info = nil
    end

    student_info

  end

end
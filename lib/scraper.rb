require 'open-uri'
require 'pry'

class Scraper

  attr_accessor :name, :location, :bio_url

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = doc.css('.student-card')
    student_array = []
    students.each do |student|
      @name = student.css("h4").text
      @location = student.css("p").text
      @bio_url = student.css("@href").first.value
      student_array << {:name=>@name,:location=>@location,:profile_url=>@bio_url}
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    quote = doc.css('.profile_quote')
    urls = []
    links = doc.css('.social-icon-container @href')
    links.each {|url| urls << url.value}
    twitter = ""
    linkedin = ""
    github = ""
    blog = ""
    profile_quote = ""
    bio = ""
    urls.each do |url|
      if url.include?('twitter')
        twitter = url
      elsif url.include?('linkedin')
        linkedin = url
      elsif url.include?('github')
        github = url
      else
        blog = url
      end
    end
    blog
    profile_quote = doc.css('.profile-quote').text
    bio = doc.css(".description-holder p").children.text
    student = {:twitter=>twitter, :linkedin=>linkedin, :github=>github, :blog=>blog, :profile_quote=>profile_quote, :bio=>bio}
    student.each do |k,v|
      if v == ""
        student.delete(k)
      end
    end
  end

end

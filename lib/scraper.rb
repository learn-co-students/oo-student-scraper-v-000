require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    @doc = Nokogiri::HTML(open("#{index_url}"))    
    @students = []
    @student_html = @doc.css("div.student-card")
    @student_html.each do |student|
      @student_hash ={}
      @student_hash[:name] = student.css(".student-name").text
      @student_hash[:location] = student.css(".student-location").text
      base_url = "http://127.0.0.1:4000/"
      student_url = student.css("a").map{|link| link['href']}.first.to_s
      @student_hash[:profile_url] = base_url + student_url
      @students << @student_hash
    end
    @students
  end

  def self.scrape_profile_page(profile_url)
    
  end

end


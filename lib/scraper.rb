require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    learn_webpage = Nokogiri::HTML(html)
    @student_info = [] 
    learn_webpage.css("div.student-card").each do |student|
      name = student.css("h4.student-name").text
      location = student.css("p.student-location").text
      @student_info << {:name => name, :location => location}
      profile_url = student.css("a href").text
      binding.pry 
    end
=begin 
    @number = 0 
    learn_webpage.css(). each do |student|
      profile_url = student.css().text
      @student_info[@number][:profile_url] => profile_url
      @number += 1 
    end
=end 
  end

  def self.scrape_profile_page(profile_url)
    
  end

end


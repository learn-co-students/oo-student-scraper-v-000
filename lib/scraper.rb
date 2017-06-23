require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students_array = []
    Nokogiri::HTML(open(index_url)).css("div.student-card").each do |student|
      students_array << {:name => student.css("h4.student-name").text,
      :location => student.css("p.student-location").text,
      :profile_url => student.css("a").attribute("href").text}
    end
    students_array
  end

  def self.scrape_profile_page(profile_url)
    student = Nokogiri::HTML(open(profile_url))
    student_hash = {
      :profile_quote => "#{student.css("div.profile-quote").text}",
      :bio => "#{student.css(".description-holder p").text}"
    }
    urls = student.css(".social-icon-container a").map{|link| link["href"]}
    urls.each do |url|
      if url.include?("twitter")
        student_hash[:twitter]=url
      elsif url.include?("linkedin")
        student_hash[:linkedin]=url
      elsif url.include?("github")
        student_hash[:github]=url
      else
        student_hash[:blog]=url
      end
    end
    student_hash
  end

end

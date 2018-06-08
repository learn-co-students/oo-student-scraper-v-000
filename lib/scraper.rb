require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    doc.css("div.student-card").collect do |student|
      student_info = {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
        }
      end
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_info = {
      :twitter => nil, :linkedin => nil, :github => nil, :blog => nil, :profile_quote => doc.css("div.profile-quote").text, :bio => doc.css("p").text
    }
    doc.css("div.social-icon-container a").each do |site|
      if site.attribute("href").value.include?("twitter")
        student_info[:twitter] = site.attribute("href").value
      elsif site.attribute("href").value.include?("linkedin")
        student_info[:linkedin] = site.attribute("href").value
      elsif site.attribute("href").value.include?("github")
        student_info[:github] = site.attribute("href").value
      else
        student_info[:blog] = site.attribute("href").value
      end
    end
    student_info.delete_if {|k,v| v == nil }
    student_info
  end

end

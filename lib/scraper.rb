require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_list = []
    doc = Nokogiri::HTML(open("./fixtures/student-site/index.html"))
    students = doc.css(".student-card").each do |student|
      name = student.css("h4").text
      location = student.css("p").text
      profile_url = student.css("a").attribute("href").value
      student_list << {:name => name, :location => location, :profile_url => profile_url}
     end 
    # binding.pry
   student_list
  end

  def self.scrape_profile_page(profile_url)
    profile_info = []
    doc = Nokogiri::HTML(open("#{profile_url}"))
   # binding.pry
    student_info = doc.css(".social-icon-container")
    social_media_links = student_info.css("a").each do |l|
      thislink = l.attribute("href").value 
  # binding.pry
      if thislink.include?("linkedin") 
        linkedin_url = thislink
      end
      if thislink.include?("twitter")
       twitter_url = thislink
      end
      binding.pry
      profile_info << {:twitter => twitter_url, :linkedin => linkedin_url}
    end
    binding.pry
  end
   

end


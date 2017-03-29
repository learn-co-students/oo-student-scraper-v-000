require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
  	doc = Nokogiri::HTML(open(index_url))
    students_array = []
  	doc.css("div.student-card").each {|student| student_hash = {
                                            :name => student.css("h4.student-name").text,
                                            :location => student.css("p.student-location").text,
                                            :profile_url => "./fixtures/student-site/#{student.css("a").attribute("href").value}" 
    }
    students_array << student_hash
}
    students_array 
end

  def self.scrape_profile_page(profile_url)

    profile = Nokogiri::HTML(open(profile_url))
    student_hash = {}
    profile.css("div.social-icon-container a").select { |social| link = social.attribute("href").value

      case 

      when link.include?("twitter")
          student_hash[:twitter] = link 
      when link.include?("linkedin")
          student_hash[:linkedin] = link 
      when link.include?("github")
          student_hash[:github] = link 
      when social.css("img.social-icon").attribute("src").value.include?("rss")
          student_hash[:blog] = link 
        
      end

    }

      student_hash[:profile_quote] =  profile.css("div.profile-quote").text 
      student_hash[:bio] =  profile.css("div.description-holder p").text
      student_hash
    
  end

end

 



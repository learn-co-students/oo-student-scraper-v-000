require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index = Nokogiri::HTML(open(index_url))
    students = []
    index.css("div.student-card").each do |student_card|
     students << {
        name: student_card.css("a div.card-text-container h4.student-name").text,
        location: student_card.css("a div.card-text-container p.student-location").text,
        profile_url: student_card.css("a").attribute("href").value
      }
    end
    students
  end


  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    links = profile.css("div.social-icon-container a")
    profile_attr = {}
    links.each do |link|
      if link.attribute("href").value.scan(/linkedin/) == ["linkedin"]
        profile_attr[:linkedin] = link.attribute("href").value
      elsif link.attribute("href").value.scan(/github/) == ["github"]
        profile_attr[:github] = link.attribute("href").value
      end
    end
    profile_attr
  end


    # linkedin: =>"https://www.linkedin.com/in/flatironschool",
    #   :github=>"https://github.com/learn-co,
    #   :blog=>"http://flatironschool.com",
    #   :profile_quote=>"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
    #   :bio=> "I'm a school"
    #  } 
    # }
    
  


end


binding.pry

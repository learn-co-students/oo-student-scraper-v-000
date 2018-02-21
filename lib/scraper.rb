require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    learnco = Nokogiri::HTML(html)
    students_array = []
    learnco.css("div.student-card").each do |student|
      students_array << {
      :name => student.css("h4.student_name").text,
      :location => student.css("p.student_location").text,
      :profile_url => student.css("a").attribute("href").value
        }
    #binding.pry
    end
    students_array
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    learnco = Nokogiri::HTML(html)
    student = {
      :profile_quote => learnco.css("div.vitals-text-container div").text,
      :bio => learnco.css("div.description-holder p").text
    }


  #
      #if link.css("a").attribute("href").value.include? "twitter"
    #   :twitter => learnco.css("a").attribute("href").value,
      #elsif link.css("a").attribute("href").value.include? "linkedin"
    #    :linkedin => learnco.css("a").attribute("href").value,
      #elsif link.css("a").attribute("href").value.include? "github"
    #    :github => learnco.css("a").attribute("href").value,
      #else
  #      :blog => learnco.css("a").attribute("href").value,


  #  end
    #:linkedin => learnco.css("div.social-icon-container a").attribute("href").value
    #:github => learnco.css("div.social-icon-container a").attribute("href:contains("github")").value
    #:blog => learnco.css("div.social-icon-container a").attribute("href").value
  #
#  }
    #}
    #binding.pry
  #  end
  end

end

require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []
    index_page.css(".roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_name = student.css("h4.student-name").text
        student_location = student.css("p.student-location").text
        student_profile_link = student.attribute("href").value
        students << {name: student_name, location: student_location, profile_url: student_profile_link}
      end
    end
    students        
    binding.pry

      end
    end



    student_data
    student_data.css("h4.student-name").each do |student|
      students[:name] = student.text

    end

    student_data.css("p.student-location").each do |student|
      students[:location] = student.text
    end

    student_data.css(".student-card a").each do |student|
      students[:profile_url] = student.attribute("href").value

    end
    binding.pry
  #end
    #student_profiles = student_data.css(".student-card")
    #student_urls = student_profiles.css("a").attribute("href").value


    #doc.css("div.student-card").each do |student|
    #doc.css("a href").value
    #end

      #:name => student.css("h4.student-name").text,


    #doc.css("a href").value
    #end
    #student_profiles = student_data.css("a").attribute("href")






    #locations = doc.css("p.student-location").first.text
    #doc.css("div.student-card")
  end


  def self.scrape_profile_page(profile_url)

  end

end

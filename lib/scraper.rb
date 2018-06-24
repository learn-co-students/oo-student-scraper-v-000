require 'open-uri'
require 'pry'
require 'nokogiri'
class Scraper

  def self.scrape_index_page(index_url)
    # [
    #     {:name => "Abby Smith", :location => "Brooklyn, NY", :profile_url => "students/abby-smith.html"},
    #     {:name => "Joe Jones", :location => "Paris, France", :profile_url => "students/joe-jonas.html"},
    #     {:name => "Carlos Rodriguez", :location => "New York, NY", :profile_url => "students/carlos-rodriguez.html"},
    #     {:name => "Lorenzo Oro", :location => "Los Angeles, CA", :profile_url => "students/lorenzo-oro.html"},
    #     {:name => "Marisa Royer", :location => "Tampa, FL", :profile_url => "students/marisa-royer.html"}
    #   ]
    page = Nokogiri::HTML(open(index_url))
    students = []
    page.css("div.roster-cards-container").each  do |student|
      student.css(".student-card").each do |info|
        each_student = {}
        each_student[:name] = info.css("h4").text
        each_student[:location] = info.css("p").text
        each_student[:profile_url] = info.css("a").attr("href").text
        students << each_student
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    # {:twitter=>"http://twitter.com/flatironschool",
    #   :linkedin=>"https://www.linkedin.com/in/flatironschool",
    #   :github=>"https://github.com/learn-co,
    #   :blog=>"http://flatironschool.com",
    #   :profile_quote=>"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
    #   :bio=> "I'm a school"
    #  }
    student_page = Nokogiri::HTML(open(profile_url))
    student_info = {}
    student_info[:profile_quote] = student_page.css(".profile-quote").text
    student_info[:bio] = student_page.css(".description-holder p").text
    student_page.css(".social-icon-container a").each do |info|
      link = "#{info.attr("href")}"
      if link.include?("twitter")
        student_info[:twitter] = link
      elsif link.include?("linkedin")
        student_info[:linkedin] = link
      elsif link.include?("github")
        student_info[:github] = link
      else
        student_info[:blog] = link
      end
    end
    student_info
  end

end

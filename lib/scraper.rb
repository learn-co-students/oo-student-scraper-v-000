require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    #binding.pry
    #name : doc.css(".student-name").text
    #location: doc.css(".student-location").children.text
    #profile_url: doc.css(".student-card").children[1].attributes["href"].value OR student.css("a")[0].attributes["href"].value
    students_array = []
    doc.css(".student-card").each do |student|
      students = {
      :name => student.css(".student-name").text,
      :location => student.css(".student-location").children.text,
      :profile_url => student.css("a")[0].attributes["href"].value
    }
      students_array << students
    end
    students_array
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    #binding.pry
    #twitter : profile.css(".social-icon-container").children.css("a")[0].attributes["href"].value
    #linkedin: profile.css(".social-icon-container").children.css("a")[1].attributes["href"].value
    #github:   profile.css(".social-icon-container").children.css("a")[2].attributes["href"].value
    #profile_quote: profile.css(".profile-quote").children.text
    #bio: profile.css(".details-container").children.css("p").children.text
    student_profile = {}
    profile.css(".social-icon-container a").each do |link|
      #binding.pry
      link_text = link.attribute("href").value
        if link_text.include?("twitter")
          student_profile[:twitter] = link_text

        elsif link_text.include?("linkedin")
          student_profile[:linkedin] = link_text

        elsif link_text.include?("github")
          student_profile[:github] = link_text
        else
          student_profile[:blog] = link_text
        end
      end
      student_profile[:profile_quote] = profile.css(".profile-quote").children.text
      student_profile[:bio] = profile.css(".details-container").children.css("p").children.text
      student_profile
      #binding.pry
    end

end

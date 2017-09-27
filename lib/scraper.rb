require 'open-uri'
require 'pry'
require 'nokogiri'


class Scraper

  def self.scrape_index_page(index_url)
    website = Nokogiri::HTML(open(index_url))
    students = []
    website.css(".student-card").each do |student|
      students << new_student = {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attr("href").value
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    student_site = Nokogiri::HTML(open(profile_url))
       #gets links:
    link_array = student_site.css(".social-icon-container").children.css("a").collect {|link| link.attribute('href').value}

    profile_page = {
      :twitter => link_array.find {|link| link.include?("twitter")},
      :linkedin => link_array.find {|link| link.include?("linkedin")},
      :github => link_array.find {|link| link.include?("github")},
      :blog => link_array.find {|link| !link.include?("twitter") && !link.include?("linkedin") && !link.include?("github")},
      :profile_quote => student_site.css(".vitals-text-container .profile-quote").text,
      :bio => student_site.css(".description-holder p").text
    }
    profile_page.delete_if{|k,v| v == nil}
  end

end

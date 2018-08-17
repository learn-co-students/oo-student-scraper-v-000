require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = Nokogiri::HTML(open(index_url))
    students = []
     html.css(".student-card a").each do |student|
       students << {
        name: student.css("h4.student-name").text,
        location: student.css("p.student-location").text,
        profile_url: "./fixtures/student-site/#{student["href"]}"

        # student.css("div.student-card a").each {|url| :profile_url => "./fixtures/student-site/#{url.attr('href')}"}
      }
      # binding.pry
    end
    students
  end
# project.css("div.student-card a")"./fixtures/student-site/#{student.attr('href')
#
  def self.scrape_profile_page(profile_url)
    html = Nokogiri::HTML(open(profile_url))
    student_profile = {}
    links = []
    html.css("div.vitals-container").each do |student|
      student.css(".social-icon-container a").each do |link|
        if "#{link["href"]}".include?("twitter")
          student_profile[:twitter]= "#{link["href"]}"
        elsif "#{link["href"]}".include?("linkedin")
          student_profile[:linkedin]= "#{link["href"]}"
        elsif "#{link["href"]}".include?("github")
          student_profile[:github]= "#{link["href"]}"
        else
          student_profile[:blog] =  "#{link["href"]}"
        end

      end
      student_profile[:profile_quote]= student.css("div.vitals-text-container .profile-quote").text
      student_profile[:bio] = html.css("div.details-container .description-holder p").text


    end

      student_profile
  end

end

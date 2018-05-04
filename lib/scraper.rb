require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students_index = Nokogiri::HTML(open(index_url))
    scraped_students = []
    #iterate over each student-card, adding a hash (of the student's name, location and profile) to the scraped_students array each time
    students_index.css("div.student-card").each do |student|
      scraped_students << {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
          }
    end
        scraped_students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    student_profile = {
      :profile_quote => profile_page.css("div.main-wrapper.profile .vitals-text-container .profile-quote").text,
      :bio => profile_page.css("div.main-wrapper.profile .description-holder p").text
        }


    # iterate over each social icon container and add each link to student profile hash (only if present)
    profile_page.css("div.main-wrapper.profile .social-icon-container a").each do |social_link|
      if social_link.attribute("href").value.include?("twitter")
        student_profile[:twitter] = social_link.attribute("href").value
      elsif social_link.attribute("href").value.include?("linkedin")
        student_profile[:linkedin] = social_link.attribute("href").value
      elsif social_link.attribute("href").value.include?("github")
        student_profile[:github] = social_link.attribute("href").value
      else
        student_profile[:blog] = social_link.attribute("href").value
      end
    end

    student_profile
  end


end

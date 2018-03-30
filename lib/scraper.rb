require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_list = []
    html = open(index_url)
    messy_code = Nokogiri::HTML(html)
    #iterate through each student
    cleaner_code = messy_code.css('.roster-cards-container .student-card')
    cleaner_code.each do |student|
      name = student.css(".card-text-container .student-name").text
      location = student.css(".card-text-container .student-location").text
      #get student profile based on the name variable
      profile_url = "students/#{name.split.join("-").downcase}.html"
      each_student = {:name => name, :location => location, :profile_url => profile_url}
      #add to master student_list
      student_list << each_student
    end
    student_list
  end


  def self.scrape_profile_page(profile_url)
    student_profile = {}
    html = open(profile_url)
    messy_code = Nokogiri::HTML(html)
    cleaner_code = messy_code.css('.vitals-container')
    #grabs social links
    cleaner_code.each do |student|
      student.css('.social-icon-container a').map do |link|
          if link['href'].include?('twitter')
            twitter = link['href']
            student_profile.merge!(:twitter=> twitter)
          elsif link['href'].include?('github')
            github = link['href']
            student_profile.merge!(:github=> github)
          elsif link['href'].include?('linkedin')
            linkedin = link['href']
            student_profile.merge!(:linkedin=> linkedin)
          elsif link['href'] != nil #if an existing link isn't any of the above, it must be for the blog
            blog = link['href']
            student_profile.merge!(:blog=> blog)
          end
        end
    end
   #grabs the quote
    cleaner_code.each do |student|
      cleaner_code = messy_code.css('.vitals-text-container')
      student_profile.merge!(:profile_quote=> cleaner_code.css('.profile-quote').text)
    end
    #grabs the bio
    student_profile.merge!(:bio=> messy_code.css('.description-holder p').text)
  end

end

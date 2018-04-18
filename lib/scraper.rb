require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_list = []
    messy_code = Nokogiri::HTML(open(index_url))
    #iterate through each student
    messy_code.css('.student-card').each do |student|
      student_list << {
      :name => student.css(".card-text-container .student-name").text,
      :location => student.css(".card-text-container .student-location").text,
      #get student profile based on the name variable
      :profile_url => "students/#{student.css(".card-text-container .student-name").text.split.join("-").downcase}.html"
      }
    end
    student_list
  end


  def self.scrape_profile_page(profile_url)
    student_profile = {}
    messy_code = Nokogiri::HTML(open(profile_url))
    #grabs social links
    messy_code.css('.vitals-container').each do |student|
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
    student_profile.merge!(:profile_quote=> messy_code.css('.profile-quote').text)
    #grabs the bio
    student_profile.merge!(:bio=> messy_code.css('.description-holder p').text)
  end

end

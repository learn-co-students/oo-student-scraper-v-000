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
    cleaner_code = messy_code.css('.vitals-container .social-icon-container')

    #goes through the first div section to grab social links
    cleaner_code.each do |student|
      social = student.css('a').map { |link| link['href'] }
      student_profile = {:twitter=> social[0], :linkedin=> social[1], :github=> social[2], :blog=> social[3]}
    end

   #goes through the second div section to grab the quote
    cleaner_code.each do |student|
      cleaner_code = messy_code.css('.vitals-container .vitals-text-container')
      student_profile.merge!(:profile_quote=> cleaner_code.css('.profile-quote').text)
    end
              binding.pry
    #goes through the third div section to grab the bio
     cleaner_code.each do |student|
       cleaner_code = messy_code.search('.details-container .bio-block details-block .bio-content content-holder')
       student_profile.merge!(:bio=> cleaner_code.css('.description-holder').text)
     end
  end

end

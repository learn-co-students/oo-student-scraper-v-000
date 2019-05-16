require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    # binding.pry
    # indiv_person_hash = {} # create hash to store information
    array_if_indiv_person_hash = []
    html = File.read(index_url) #pulls html
    student_file = Nokogiri::HTML(html) #full html node doc
    # student_file.css(".student-card") #student box
    # binding.pry
    student_file.css(".student-card").each do |student_box| #iterate over each student card
      # binding.pry
      array_if_indiv_person_hash << { #adds hash to array and creates keys
        :name => student_box.css("h4.student-name").text, #name symbol
        :location => student_box.css("p.student-location").text, #location symbol
        :profile_url => "./fixtures/student-site/#{student_box.css("a").attribute("href").text}" #profile url symbol
        #:profile_url => student_box.css("a").attribute("href").text
      }
    end
    array_if_indiv_person_hash #array
  end

  def self.scrape_profile_page(profile_url)

    html = File.read(profile_url) #pulls html
    student_profile_page = Nokogiri::HTML(html) #full html node doc
    array = [] #creates array
    student_profile_page.css(".social-icon-container a").each do |each_a_link| #loops over each social media links
      array << each_a_link.attribute("href").text #sovels each into array
    end

    student_profile_hash = {
      :twitter=> array.find { |e| /twitter/ =~ e },
      :linkedin=> array.find { |e| /linkedin/ =~ e },
      :github=> array.find { |e| /github/ =~ e },
      :blog=> array[3],
      :profile_quote=> student_profile_page.css(".vitals-text-container .profile-quote").text,
      :bio=> student_profile_page.css(".description-holder p").text
    }

      student_profile_hash_two = {}
      student_profile_hash.each do |key, value|
        if value == nil || value == "nil"
        else
          student_profile_hash_two[key] = value
        end
      end

      student_profile_hash_two
      # add_student_attributes(student_profile_hash_two)
  end
end

require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
 
  def self.scrape_index_page(index_url)
    #doc = Nokogiri::HTML(open(index_url))
    doc = Nokogiri::HTML(open(index_url+'/fixtures/student-site/index.html'))
    student_array =[]
    doc.css(".student-card").each do |card|  
      student_hash = {}
      student_hash =  {
      :name => card.css(".student-name").text,
      :location => card.css(".student-location").text,
      :profile_url => "http://127.0.0.1:4000/" + card.css("a").attr('href').text
      }
      student_array << student_hash
    end
    student_array #do not move or delete
  end

  def self.scrape_profile_page(profile_url)
#----------------------------
      # This is a class method that should take in an argument of a student's profile
      # URL. It should use nokogiri and Open-URI to access that page. The return value
      # of this method should be a hash in which the key/value pairs describe an 
      # individual student. Some students don't have a twitter or some other social link.
      # Be sure to be able to handle that. Here is what the hash should look like:
      # # => {:twitter=>"http://twitter.com/flatironschool",
      #       :linkedin=>"https://www.linkedin.com/in/flatironschool",
      #       :github=>"https://github.com/learn-co,
      #       :blog=>"http://flatironschool.com",
      #       :profile_quote=>"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
      #       :bio=> "I'm a school"
      #      }
#----------------------------
binding.pry
    doc = Nokogiri::HTML(open(profile_url))
    profile_page_hash = {}          
    doc.css(".social-icon-container a").each do |link|        
      if link.attr('href').include?("twitter")
        profile_page_hash[:twitter] = link.attr('href')
      elsif link.attr('href').include?("linkedin")
        profile_page_hash[:linkedin] = link.attr('href')
      elsif link.attr('href').include?("github")
        profile_page_hash[:github] = link.attr('href') 
      else
       profile_page_hash[:blog] = link.attr('href')
    end
  end        
  profile_page_hash[:profile_quote] = doc.css("div.vitals-text-container div.profile-quote").text
  profile_page_hash[:bio] = doc.css("div.description-holder p").text
  profile_page_hash #do not move or delete
  end

end


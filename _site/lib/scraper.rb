require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper





  def self.scrape_index_page(index_url)
    student_arr = []
    student_hash = {}
doc = Nokogiri::HTML(open("http://students.learn.co/"))
    binding.pry

    student_names = doc.css(".student-card").css("h4")
    student_location  = doc.css(".student-card").css("p")
    #profile_url = []

     i=0
    student_hash = {
      :name => student_names.text,
      :location => student_location.text
      }
      while i <= student_names.size

        i+=1
      end
    student_arr << student_hash

    end
#student_arr



   # student_hash={
     # :name => doc.css(".student-card").css("h4").text ,
    #  :location => doc.css(".student-card").css("p").text ,
    #  :profile_url => doc.css(".student-card").css("a")[0]["href"]
    #  }




  def self.scrape_profile_page(profile_url)

  end

end


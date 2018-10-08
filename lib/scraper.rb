require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  @@student_info = []

  def self.scrape_index_page(index_url)
    student_site = Nokogiri::HTML(open(index_url))
    
    student_site.css(".student-card").each do |student|
      i = 0
      student_hash = {
        :name => student.css(".card-text-container").css(".student-name").text,
        :location => student.css(".card-text-container").css(".student-location").text,
        :profile_url => student.css("a")[i]["href"]
      }
      @@student_info << student_hash
      i += 1
    end
    # binding.pry
    @@student_info
  end

  def self.scrape_profile_page(profile_url)
    # @@student_info.each do |student|
    #   i = 0
    #   profile = student[i][:profile_url]
    #   # all method code in here
    #   i += 1
    # end
    # profile_url = "./fixtures/student-site/#{profile}"

    student_profile = Nokogiri::HTML(open(profile_url))

    student_profile_hash = {
      :twitter => ,
      :linkedin => ,
      :github => ,
      :blog => ,
      :profile_quote => ,
      :bio => 
    }

  end

end


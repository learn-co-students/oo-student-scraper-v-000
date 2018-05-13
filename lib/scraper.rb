require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  # def self.get_page
  #   doc = Nokogiri::HTML(open(index_url))
  # end

  def self.scrape_index_page(index_url)
    results = []
    doc = Nokogiri::HTML(open(index_url))
    students = doc.css("div.student-card")
    # names = doc.css(".student-card").css(".student-name").text
    # locations = doc.css(".student-card").css(".student-location").text
    # profile_url= doc.css(".student-card").css(".href").text


    students.each do |student|
      results << {:name => student.css("h4.student-name").text,
      :location => student.css("p.student-location").text,
     :profile_url => "http://192.241.157.192:41735/fixtures/student-site/#{student.css("a").first["href"]}"}
    #  "http://127.0.0.1:4000/fixtures/student-site/#{i.css("a").first["href"]}"
    # :location => student.css("a").css(".a").text}

    # name = doc.css(".student-card").css(".student-name").text
    # location = doc.css(".student-card").css(".student-location").text
    # profile_url= doc.css(".student-card").css(".href").text


end
results
  end

  def self.scrape_profile_page(profile_url)

  end

end

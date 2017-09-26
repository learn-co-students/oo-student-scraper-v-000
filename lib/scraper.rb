require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))


    binding.pry

    # this is just an example: 
    # doc.css(".post").each do |post|
    #   student = Student.new
    #   student.title = post.css("h2").text
    #   student.schedule = post.css(".date").text
    #   student.description = post.css("p").text
    # end

  end

  def self.scrape_profile_page(profile_url)

  end

end

require 'open-uri'
require 'pry'

class Scraper

  def self.get_page(url)
    Nokogiri::HTML(open(url))
  end

  def self.scrape_index_page(index_url)
    # {:name => "Abby Smith", :location => "Brooklyn, NY", :profile_url => "students/abby-smith.html"}
    doc = get_page(index_url)
    binding.pry
    doc = Nokogiri::HTML(open(index_url))

    students = {}
    doc.css(".student-card").each do |student|
      student = {
        :name => doc.css(".student-card h4.").text,
        :location => doc.css(".student-card p").text,
        :profile_url => 
      }


    ###URL LINK
    # doc.css(".student-card a")[0].each do |link|
    #   puts link[1]
    # end

    ###NAME
    # doc.css(".student-card h4.").text

    # doc.css(".student-card h4")[0].each do |name|
    #   name.text
    # end


    ###Location
    # doc.css(".student-card p")[0].text


  end

  def self.scrape_profile_page(profile_url)

  end

end

require 'open-uri'
require 'nokogiri'
require 'pry'

require_relative './student.rb'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open("./fixtures/student-site/"))
    info = {}
    doc.css(".roster-cards-container").each do |details|
      name = details.css("").text
        details[name] = {
          :location => details.css("").text
          :profile_url => details.css(" ..... a img").attribute("src").value

 end

  :name :location, :profile_url
    get_students
    #/fixtures/student-site/
  end



  def get_students
    self.get_page.css
     # this returns the array
  end
   #
  #  return array of hashes with
  #  :name :location, :profile_url
   #
  #  return :linkedin  :github  :blog  :profile_quote :bio

    # doc = Nokogiri::HTML(open("index_url"))

end
def self.scrape_profile_page(profile_url)
  get_page

end

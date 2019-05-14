require_relative "../lib/student.rb"
require 'open-uri'
require 'pry'

class Scraper
 
# index_url = '.fixtures/student-site.index.html'
# top layer page scrape, make student, get these attributes:
# students_array (array of indiv student hashes) = 
#   [{:name => "Abby Smith",:location => "Brooklyn, NY",:profile_url => "students/abby-smith.html"}, 
#    {:name => } ]

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(File.read(index_url))
  
    doc.css('div.student-card').map do |student|
       {:name => student.css('h4').text, 
       :location => student.css('p').text,
       :profile_url => student.css('a').attribute('href').value}
    end
  end    

# second layer scrape indiv student profile pages:
#  def self.scrape_profile_page(profile_url)
#
#  end
end

require 'nokogiri' #"fine-toothed-saw"
require 'open-uri' #Ruby module that shipped with ruby but needs to imported..i think..?

require 'pry'

index_page_url = "https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"

 class Scraper

   def scrape_index_page(index_page_url)
     html_grab = open(index_page_url)
     #uses OPEN-URImodule in Ruby to grab the HTML of the site
     noko_html_grab = Nokogiri::HTML(html_grab)
     #uses HTML method in the NOKOGIRIgem to translate into  nested nodes for easier scraping
    #  :name =>
    #  :location =>
    #  :profile_url =>

   end

   def scrape_profile_page
   end

 end #<-----CLASSend

 Scraper.scrape_index_page

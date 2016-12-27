require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    learn = Nokogiri::HTML(html)


      scraper_array = []
      hash = {}
      # name = learn.css(".student-name")
      # url = learn.css('a[href]').map{|link| link['href']}
      # binding.pry


          # binding.pry
          # hash[:name] = item.css(".student-name").text
          # hash[:location] = item.css(".student-location").text
          # hash[:profile_url] = item.css('a[href]').map{|link| link['href']}



     learn.css(".student-name").zip(".student-location"), ('a[href]') do |name, location, profile_url|
       hash = {}
       hash[:name] = (".student-name").text
       hash[:location] = (".student-location").text
       hash[:profile_url] = ('a[href]').map{|link| link['href']}
     
     end

     end
# end
      # learn.css(".student-name").css(".student-location").css("a[href]").map do |each_value|
      #   binding.pry
      #   name = {:name = each_name.text}
      #  end
      #
      # learn.css(".student-location").map do |each_location|
      #   location = {:location = each_location.text}
      # end
      #
      # names = learn.css('a[href]').map{|link| link['href']}
      #   names.map do |each_url|
      #     url = {:profile_url = "./fixtures/student-site/" + each_url}
      #   end
      #
      #     scraper_array << scraper



  def self.scrape_profile_page(profile_url)
    html_file = File.read(profile_url)
    doc = Nokogiri::HTML(html_file)


  end

end

Scraper.scrape_index_page("./fixtures/student-site/index.html")
Scraper.scrape_profile_page("./fixtures/student-site/students/joe-burgess.html")

require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    htmlcode= Nokogiri::HTML(html)
    profiles= []
    binding.pry
    htmlcode.css('.student-card').each { |dat|

                    hash = {  :profile_url => dat.css('a').attribute('href').value   }

                    profiles.push(hash)
    }
  #    htmlcode.css('.student-card a').attribute('href').value
   binding.pry
  end

  def self.scrape_profile_page(profile_url)

  end

end

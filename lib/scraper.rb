require 'open-uri'
require 'pry'

class Scraper

attr_accesor :name, :location, :profile_url



  def self.scrape_index_page(index_url)
      Nokogiri::HTML(open(index_url))
      binding.pry
  end


  def self.scrape_profile_page(profile_url)

  end

end

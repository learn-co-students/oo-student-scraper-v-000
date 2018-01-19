require 'open-uri'
require 'pry'

class Scraper
  attr_accessor :name, :location, :profile_url

  # def initialize(index_url)
  #   doc = Nokogiri::HTML(open(index_url))
  #
  #   props = {}
  #
  #   props[:name] = doc.search("h1.profile-name")
  #   props[:location] = doc.search("h2.profile-location")
  #   props[:profile_url] = doc.search("not-sure")
  #
  #   props
  # end


  def self.scrape_index_page(index_url)
    @doc = Nokogiri::HTML(open(index_url))
    props = {}

    props[:name] = @doc.search("h1.profile-name")
    props[:location] = @doc.search("h2.profile-location")
    props[:profile_url] = @doc.search("not-sure")

    props
  end



    # @name = doc.css("h1.class.profile_name")
  #   @name = doc.css(".vitals-container .vitals-text-container .h1.profile-name")
  # #   @location =doc.css(".vitals-container .vitals-text-container .h2")
  # #   @profile_url = doc.css(".vitals-container .vitals-text-container .h1") return the actual url in this one so it can be passed through to the self.scrape_profile_page method



  # self.new_from_example(index_url)
  #   properties = scraper.new
  #   properties.each do |k,v|
  #     scraper.send("#{k}=", v)
  #   end
  # end

    def self.scrape_profile_page(profile_url)

    end


end

require 'open-uri'
require 'pry'

class Scraper
  attr_accessor :name, :location, :profile_url

  def initialize(index_url)
    @doc = Nokogiri::HTML(open(index_url))
  end

  def call
    box.each do |box_doc|
      scrape_index_page(box_doc)
    end
  end

  def box
    @box ||= @doc.search("div.student-card")
  end

  def self.scrape_index_page(index_url)
    @doc = Nokogiri::HTML(open(index_url))
    @box ||= @doc.search("div.student-card")
      binding.pry
    scraped_students = []
    @box.each do |student|
      student = {
          :name =>  @box.search("h4.student-name").text,
          :location => @box.search("p.student-location").text,
          :profile_url => @box.search("div.student-card a").attribute("href").text,
        }
        scraped_students << student
      end
  end


    def self.scrape_profile_page(profile_url)

    end


end

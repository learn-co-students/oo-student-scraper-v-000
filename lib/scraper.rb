require 'open-uri'
require 'pry'

class Scraper
  attr_accessor :name, :location, :profile_url

  def initialize(index_url)
    @doc = Nokogiri::HTML(open(index_url))
  end

  def self.scrape_index_page(index_url)
    @doc = Nokogiri::HTML(open(index_url))
    @box ||= @doc.search(".student-card")
    students = []
      @box.each do |student|
        student_hash = {
            :name =>  student.search("h4").text,
            :location => student.search("p").text,
            :profile_url => student.search("a").attribute("href").value,
          }
          students << student_hash
        end
    students
  end


    def self.scrape_profile_page(profile_url)
      @profile = Nokogiri::HTML(open(profile_url))
      binding.pry
      # Social Media and Blog are all in the same area, and are all a tags, but don't really have a lot to differentiate as far as classes go. will probably need to point to the src? no idea really
      # ("a").attribute("href").value => gives the social media URLs
      # blog
      # :profile_quote => @profile.search(".profile-quote").text
      # :bio => @profile.search("p").text
    end


end

require 'open-uri'
require 'pry'
require 'nokogiri'
class Scraper


  attr_accessor :name, :location, :profile_url

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_names = []
    doc.css(".roster-cards-container .student-card").each do |student|
      # name = student.css(".student-name").text
      #
      # location = student.css(".student-location").text
      #
      # profile_url = student.at_css("a").attr('href')

      student_names <<  {:name =>  student.css(".student-name").text,
        :location =>  student.css(".student-location").text,
        :profile_url => student.at_css("a").attr('href')}


      end
      student_names

    end

    # {[{:name=>"Joe Burgess", :location=>"New York, NY", :profile_url=>"students/joe-burgess.html"},
    #                              {:name=>"Mathieu Balez", :location=>"New York, NY", :profile_url=>"students/mathieu-balez.html"},
    #                              {:name=>"Diane Vu", :location=>"New York, NY", :profile_url=>"students/diane-vu.html"}]}
    #




    def self.scrape_profile_page(profile_url)
      profile_html = open(profile_url)
      profile_doc = Nokogiri::HTML(profile_html)
      quote =  profile_doc.css(".profile-quote").inner_text

      bio = profile_doc.css(".description-holder p").inner_text.tr("\n","")

      @attributes = {:bio => bio,
        :profile_quote => quote
        }


      profile_doc.css(".social-icon-container a").each do |icon|
      if icon.attributes["href"].text.include?("twitter")
        @attributes[:twitter] = icon.attributes["href"].text

      elsif icon.attributes["href"].text.include?("github")
        @attributes[:github] = icon.attributes["href"].text
      elsif icon.attributes["href"].text.include?("linkedin")
        @attributes[:linkedin] = icon.attributes["href"].text
      else
        @attributes[:blog] = icon.attributes["href"].text
      end



      end

      @attributes

    end








  end

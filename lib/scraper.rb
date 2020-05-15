require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    # :name => doc.css(".student-name")[0].text
    # :location => doc.css(".student-location")[0].text
    # :profile_url => doc.css(".student-card a")[0]["href"]
    student_array = []
    student_array.tap {
      doc.css(".student-name").each_with_index do |s, i|
        hash = {}
        hash[:name] = doc.css(".student-name")[i].text
        hash[:location] = doc.css(".student-location")[i].text
        hash[:profile_url] = doc.css(".student-card a")[i]["href"]
        student_array << hash
      end
    }
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    #binding.pry
    # :twitter => doc.css(".social-icon-container a")[0]["href"]
    # :linkedin => doc.css(".social-icon-container a")[1]["href"]
    # :github => doc.css(".social-icon-container a")[2]["href"]
    # :blog => doc.css(".social-icon-container a")[3]["href"]
    # :profile_quote => doc.css(".profile-quote").text
    # :bio => doc.css(".description-holder p").text
    hash = {}
    hash.tap {
    social_array = []
    doc.css(".social-icon-container a").each_with_index do |s, i|
      social_array << doc.css(".social-icon-container a")[i]["href"]
    end
    hash[:twitter] = social_array.delete(social_array.detect {|i| i[/twitter/] })
    hash[:linkedin] = social_array.delete(social_array.detect {|i| i[/linkedin/] })
    hash[:github] = social_array.delete(social_array.detect {|i| i[/github/] })
    hash[:blog] = social_array[0]
    hash[:profile_quote] = doc.css(".profile-quote").text
    hash[:bio] = doc.css(".description-holder p").text
    hash.delete_if {|k,v| v == nil}
    }
  end

end

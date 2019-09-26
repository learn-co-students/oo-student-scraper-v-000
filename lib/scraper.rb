require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students_array = []
    doc.css(".student-card").each {|s|
      hash = {}
      hash[:name] = s.css(".student-name").text
      hash[:location] = s.css(".student-location").text
      hash[:profile_url] = s.css("a")[0]['href']
      students_array << hash
    }
    students_array
    #binding.pry
    ##:name
    #s.css(".student-name").text
    ##:location
    #s.css(".student-location").text
    ##:url
    #s.css("a")[0]['href']
  end

  def self.scrape_profile_page(profile_url)

    doc = Nokogiri::HTML(open(profile_url))

    #find social attributes
    social_url = doc.css("div.social-icon-container").children.collect {|a| a['href']}
    social_url.delete(nil)
    social = social_url.collect {|s|
      tag = s.match(/[a-z]+(.com|.co)/)
      [tag.to_s.split(".")[0].to_sym, s] if tag
    }

    #add social attributes to the hash
    hash = {}
    social.delete(nil)
    social.each { |n|
      if (n[0] == :twitter) || (n[0] == :linkedin) || (n[0] == :github)
        hash[n[0]] = n[1]
      else
        hash[:blog] = n[1]
      end
    }

    #add profile_quote to the hash
    hash[:profile_quote] = doc.css("body > div > div.vitals-container > div.vitals-text-container > div").text

    #add bio to the hash
    hash[:bio] = doc.css("body > div > div.details-container > div.bio-block.details-block > div > div.description-holder > p").text
    hash
  end

end

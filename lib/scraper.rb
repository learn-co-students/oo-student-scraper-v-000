require 'nokogiri'
require 'open-uri'

class Scraper

  def self.scrape_index_page(index_url)
    base_path = File.dirname(index_url) + '/'
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card").collect { |student|
      { :name => student.css("div.card-text-container h4.student-name").text,
        :location => student.css("div.card-text-container p.student-location").text,
        :profile_url => base_path + student.css("a")[0]['href'] }
    }
  end

  def self.scrape_profile_page(profile_url)
    return_hash = {}
    doc = Nokogiri::HTML(open(profile_url))

    return_hash[:profile_quote] = doc.css("div.profile-quote").text.strip
    return_hash[:bio] = doc.css("div.bio-content div.description-holder").text.strip

    doc.css("div.vitals-container a").each { |link|
      ref = link['href']
      if ref.include?('github.com')
        return_hash['github'.to_sym] = ref
      elsif ref.include?('linkedin.com')
        return_hash['linkedin'.to_sym] = ref
      elsif ref.include?('twitter.com')
        return_hash['twitter'.to_sym] = ref
      else
        return_hash['blog'.to_sym] = ref
      end
    }

    return_hash
  end
end

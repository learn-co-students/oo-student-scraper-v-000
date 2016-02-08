require 'nokogiri'
require 'open-uri'
require 'pry'

#title doc.css(".student-card").attribute("id").value
#name: doc.css(".student-card div.card-text-container h4.student-name")
#location:  doc.css(".student-card div.card-text-container p.student-location")
#url doc.css(".student-card a").attribute("href").value


class Scraper
	
	

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card").collect do |student|
    	{
    		:name => student.css("div.card-text-container h4.student-name").text,
    		:location => student.css("div.card-text-container p.student-location").text,
    		:profile_url => index_url + student.css("a").attribute("href").value
    	}
    end
  end
  
  

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    h = {}
    profile.css("div.social-icon-container a").each do |social|
    	url = social.attribute("href").value
    	case url
    	when /twitter/
    		h[:twitter] = url
    	when /linkedin/
    		h[:linkedin] = url
    	when /github/
    		h[:github] = url
    	else
    		h[:blog] = url if url.length > 0
    	end
    end
    h[:profile_quote] = profile.css("div.vitals-text-container div.profile-quote").text
    h[:bio] = profile.css("div.details-container div.bio-block div.bio-content div.description-holder p").text
    h
  end

end


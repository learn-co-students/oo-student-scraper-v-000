require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

    def self.scrape_index_page(index_url)
        doc = Nokogiri::HTML(open(index_url))
        page_url = index_url.chomp("index.html")
        pages = doc.css("div.student-card")
        parsed_hashes = []
        pages.each { |page| 
            name = page.css("h4.student-name").text
            location = page.css("p.student-location").text
            profile_url = page.css("a").attribute("href").value
            parsed_hashes << {name: name, location: location, profile_url: page_url + profile_url}
            }

        parsed_hashes
    end

    def self.scrape_profile_page(profile_url)
        doc = Nokogiri::HTML(open(profile_url))
        links = doc.css("div.social-icon-container").css("a")
        profile = Hash.new('none')
        links.each { |link| 
            url = link.attribute("href").value
            if url.match(/twitter/)
                profile[:twitter] = url
            elsif url.match(/linkedin/)
                profile[:linkedin] = url
            elsif url.match(/github/)
                profile[:github] = url
            elsif link.css("img").attribute("src").value.match(/rss-icon/)
                profile[:blog] = url
            end
            }
        
            profile[:profile_quote] = doc.css("div.profile-quote").text
            profile[:bio] = doc.css("div.bio-content  div.description-holder p").text
            
        profile
    end

end


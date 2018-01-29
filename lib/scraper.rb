require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

        def self.scrape_index_page(index_url)
        doc = Nokogiri::HTML(open(index_url))
        attributes = []
        doc.css("div.student-card").collect do |x|
            attributes << {
                :name => x.css("h4").text,
                :location => x.css("p").text,
                :profile_url => x.css("a").attribute("href").value
                }
            end
            
        attributes       
        end

        def self.scrape_profile_page(profile_url)
            doc = Nokogiri::HTML(open(profile_url))
            social_links = doc.css("div.social-icon-container a").collect {|x| x.attribute("href").value}
            profile = {}
#            binding.pry
            social_links.collect do |x|
                if x.include?("twitter")
                    profile[:twitter] = x
                elsif x.include?("linkedin")
                    profile[:linkedin] = x
                elsif x.include?("github")
                    profile[:github] = x
                elsif !x.include?("twitter") && !x.include?("linkedin") && !x.include?("github")
                    profile[:blog] = x
                end
            end
            profile[:profile_quote] = doc.css("div.profile-quote").text
            profile[:bio] = doc.css("div.description-holder p").text.strip
            profile
        end
end
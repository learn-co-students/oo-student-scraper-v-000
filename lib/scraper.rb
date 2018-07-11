require 'open-uri'
require 'pry'

class Scraper

    def self.scrape_index_page(index_url)
        # binding.pry
        array = []
        person = {}
        Nokogiri::HTML(open(index_url)).css(".roster-cards-container .student-card").each do|eachperson|
            person = {
                :name => eachperson.css("h4").text,
                :location => eachperson.css("p").text,
                :profile_url => eachperson.css("a").attribute("href").value
            }
            array.push(person)
        end
        array
    end

    def self.scrape_profile_page(profile_url)
        # binding.pry
        profile = {}
        doc = Nokogiri::HTML(open(profile_url)).css(".social-icon-container a").map{|link| link.attribute('href').value}
        profile = {
        :twitter => doc.find{|link| link.include?("twitter")},
        :linkedin => doc.find{|link| link.include?("linkedin")},
        :github => doc.find{|link| link.include?("github")},
        :blog => doc.find{|link| !link.include?("twitter") && !link.include?("github") && !link.include?("linkedin")},
        :profile_quote => Nokogiri::HTML(open(profile_url)).css("div.profile-quote").text,
        :bio => Nokogiri::HTML(open(profile_url)).css(".description-holder").css("p").text
        }
        profile.delete_if {|key, value| value == nil}
    end
end

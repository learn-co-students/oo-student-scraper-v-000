require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    roster_cards = doc.css(".roster-cards-container")

    roster_cards.css(".student-card").collect do |student|
      {:name => student.css("h4").text,
       :location => student.css("p").text,
       :profile_url => "http://127.0.0.1:4000/#{student.css("a").attribute("href").value}"}
    end
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    hyperlinks = doc.css("a")
    hyperlinks_array =[]
    hyperlinks.each do |hyperlink|
      hyperlinks_array << hyperlink.attribute("href").value
    end

    a_twitter = hyperlinks_array.detect {|w| w.split("/").include?("twitter.com") }
    a_linkedin = hyperlinks_array.detect {|w| w.split("/").include?("www.linkedin.com") }
    a_github = hyperlinks_array.detect {|w| w.split("/").include?("github.com") }
    a_blog = hyperlinks_array.detect {|w|
      !w.split("/").include?("github.com") &&
      !w.split("/").include?("www.linkedin.com") &&
      !w.split("/").include?("twitter.com") &&
      !w.include?("../")}
    a_profile_quote = doc.css(".profile-quote").text
    a_bio = doc.css(".bio-content .description-holder").text.strip

    display_hash = {}

    display_hash[:twitter] = a_twitter if a_twitter
    display_hash[:linkedin] = a_linkedin if a_linkedin
    display_hash[:github] = a_github if a_github
    display_hash[:blog] = a_blog if a_blog
    display_hash[:profile_quote] = a_profile_quote if a_profile_quote
    display_hash[:bio] = a_bio if a_bio

    display_hash
   end

end

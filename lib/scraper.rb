require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    #transform input into html variable
    html = Nokogiri::HTML(open(index_url))

    #Create hash to populate with index page data
    index_page_data = []

    #select all roster-cards in html page
    html.css(".student-card").each do |card|

      #create student_card hash with name, location, and profile_url
      student_card = {
        :name => card.css(".student-name").text,
        :location => card.css(".student-location").text,
        :profile_url => card.css("a")[0]['href']
      }

      #push student_card hash to index_card_array
      index_page_data << student_card
      end

    #return index_page_data array
    index_page_data

  end

  def self.scrape_profile_page(profile_url)

    #transform profile_url into html variable
    html = Nokogiri::HTML(open(profile_url))

    #create empty hash to return

    profile_data = {}

    #iterate throuugh each link on page
    html.css(".social-icon-container").children.css("a").each do |link|

      #if url is for social site, pull name from url
      if link['href'].include?('twitter')
        profile_data[:twitter] = link['href']
      elsif link['href'].include?('github')
        profile_data[:github] = link['href']
      elsif link['href'].include?('linkedin')
        profile_data[:linkedin] = link['href']
      #otherwise, link is for user's blog
      else
        profile_data[:blog] = "#{link['href']}"
      end

    end

    #pull profile quote and bio
    profile_data[:profile_quote] = "#{html.css(".profile-quote").text}"
    profile_data[:bio] = "#{html.css(".bio-content p").text}"

    #return hash
    profile_data
  end

end

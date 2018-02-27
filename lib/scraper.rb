require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    student_cards = doc.css(".student-card a")
    student_cards.collect do |element|
      {:name => element.css(".student-name").text ,
       :location => element.css(".student-location").text,
        :profile_url => element.attr('href')
      }

    end
  end

  def self.scrape_profile_page(profile_url)
    profile = Hash.new
    html = open(profile_url)
    page = Nokogiri::HTML(html)

    if page.css(".social-icon-container")
      page.css(".social-icon-container a").each do |a|
        social = a["href"]
        if social.include?("twitter")
          profile[:twitter] = social
       elsif social.include?("linkedin")
         profile[:linkedin] = social
       elsif social.include?("github")
          profile[:github] = social
        else
          profile[:blog] = social
        end
      end
    end

    if page.css(".profile-quote")
      profile[:profile_quote] = page.css(".profile-quote").text
    end

    if page.css(".bio-content")
      profile[:bio] = page.css(".bio-content p").text
   end

    profile
  end

end

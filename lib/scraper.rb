require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_cards = Nokogiri::HTML(open(index_url)).css(".student-card")
    students_array = Array.new.tap do |array|
      student_cards.each do |card|
        array.push({
          :name => card.css(".student-name").text,
          :location => card.css(".student-location").text,
          :profile_url => card.css("a").attr("href").text
        })
      end
    end
      
  end



  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))

    attributes_hash = Hash.new.tap do |h|

      page.css(".social-icon-container a").each do |link|
        icon = link.css("img").attr("src").value
        case icon
        when /github/
          h[:github] = link.attr("href")
        when /twitter/
          h[:twitter] = link.attr("href")
        when /linkedin/
          h[:linkedin] = link.attr("href")
        when /rss/
          h[:blog] = link.attr("href")
        end
      end

      h[:profile_quote] = page.css(".profile-quote").text
      h[:bio] = page.css(".bio-content p").text

    end
    
  end
    
end

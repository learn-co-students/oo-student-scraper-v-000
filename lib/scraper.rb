require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card").collect do |a|
      scraped_students = {
        :name => a.css(".student-name").text,
        :location => a.css(".student-location").text,
        :profile_url => a.css("a").attribute("href").value
      }
    end
  end

  def self.scrape_profile_page(profile_url)
    student = {}
    doc = Nokogiri::HTML(open(profile_url))

    doc.css(".social-icon-container").each do |a|
      a.css("a").each do |b|
        social_icon = b.children[0].attribute("src").value
        link = b.attribute("href").value

          if social_icon.include?("linkedin")
            student[:linkedin] = link
          elsif social_icon.include?("github")
            student[:github] = link
          elsif social_icon.include?("twitter")
            student[:twitter] = link
          elsif social_icon.include?("rss")
            student[:blog] = link
          end
        end
      end
    student[:profile_quote] = doc.css("div.profile-quote").text
    student[:bio] = doc.css("div.description-holder p").text
    student
  end

end

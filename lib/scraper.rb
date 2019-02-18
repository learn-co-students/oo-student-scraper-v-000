require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    roster = Nokogiri::HTML(html)
    students = []
    roster.css(".student-card").each do |student_card|
  
    students << {
      :name => student_card.css(".student-name").text,
      :location => student_card.css(".student-location").text,
      :profile_url => student_card.css("a").attribute("href").value
    }
    
    end
    students
  end

  def self.scrape_profile_page(profile_url)
      html = File.read(profile_url)
      profile_page = Nokogiri::HTML(html)
      student_profile = {}
      profile_page.css(".profile").each do |div|
        div.css(".social-icon-container a").each do |a|
                # a.at_css("a[href*='rss']")
                #=> returns nil OR returns matching element
            if a.attribute("href").value.include?("twitter")
              student_profile[:twitter] = a.attribute("href").value
            # end
            elsif a.attribute("href").value.include?("linkedin")
              student_profile[:linkedin] = a.attribute("href").value
            # end
            elsif a.attribute("href").value.include?("github")
              student_profile[:github] = a.attribute("href").value
            # end
            else # a.at_css("a img[src*='rss-icon']") != nil
              # binding.pry
              student_profile[:blog] = a.attribute("href").value
            end
        end
  
        student_profile[:profile_quote] = div.css(".profile-quote").text
        student_profile[:bio] = div.css(".bio-content .description-holder p").text
    end
   student_profile
  end
  
  # self.scrape_index_page("./fixtures/student-site/index.html")

end


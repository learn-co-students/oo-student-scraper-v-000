require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))

    students = []
    index_page.css(".student-card").each do |card|

      hash = {
      :name => card.css(".card-text-container h4").text,
      :location => card.css(".card-text-container p").text,
      :profile_url => card.css("a").attribute("href").value
      }
    students << hash
    end
    students
  end
  # all in .student-card.. or roster-cards-container
# name = doc.css(".card-text-container").first.css("h4").text
# location = doc.css(".card-text-container").first.css("p").text
# profile_URL = doc.css(".roster-cards-container").first.css(".student-card a").first.attribute("href").value

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    # binding.pry
    student = {}
    links = profile_page.css(".social-icon-container").children.css("a").map {|i| i.attribute("href").value}
    links.each do |link|
      if link.include?("twitter")
        student[:twitter] = link
      elsif link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      else link.include?("blog")
        student[:blog] = link
      end
    end
        student[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")

        student[:bio] = profile_page.css(".bio-content.content-holder .description-holder p").text if profile_page.css(".bio-content.content-holder .description-holder p")
      student
      # binding.pry
    end
  end


# "div.bio-content .content-holder div.description-holder p")
#   body > div > div.vitals-container > div.details-container > div.bio-block.details-block > div > div.description-holder > p
  # :twitter=>"http://twitter.com/flatironschool",
  #       :linkedin=>"https://www.linkedin.com/in/flatironschool",
  #       :github=>"https://github.com/learn-co,
  #       :blog=>"http://flatironschool.com",
  #       :profile_quote=>"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
  #       :bio=> "I'm a school"
# profile_page.css(".social-icon-container").children.css("a").attribute("href").value
#profile_page.css(".profile-quote").text

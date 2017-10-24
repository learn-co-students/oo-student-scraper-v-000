require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    # binding.pry
    students = []
    doc.css(".student-card").each do |card|

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
    # [
    #   {:twitter,
    #   :linkedin,
    #   :github,
    #   :profile_quote,
    #   :bio}
    # ]
  end

end

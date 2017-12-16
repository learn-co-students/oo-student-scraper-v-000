require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    card = []
    student_card = doc.css("div.student-card").each do |student|
      card << {:name => student.css("h4.student-name").text}
    end
    card
  end

  def self.scrape_profile_page(profile_url)

  end

end

# doc.css("div.roster-cards-container").each do |student|
#   student = [
#     {:name => student.css("h4.student-name").text}
#   ]
# end
#
# roster = doc.css("div.roster-cards-container")
# student_card = doc.css("div.student-card")
# student_card.css("h4.student-name").text

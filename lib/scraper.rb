require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
   #binding.pry
   doc = Nokogiri::HTML(open("http://67.205.146.216:30000/fixtures/student-site/"))
      doc.css("div.roster-cards-container").collect do |roster|
        {
          :location => doc.css(".roster-cards-container").first.css("p").text
          :name => doc.css(".roster-cards-container-text-container").first.css("h4").text
        }
  end
end


=begin
  def self.scrape_profile_page(profile_url)
  {
    :twitter =>
    :linkedin =>
    :github =>
    :blog =>
    :profile_quote =>
    :bio =>
}


    end
end

=begin UNABLE TO GET CODE TO EXTRACT THE URL
    doc.css("div.roster-cards-container").collect do |roster|
    {
      :name => doc.css(".card-text-container").first.css("h4").text #returns just one student, should I be returning all students??
      or I can use doc.css(".roster-cards-container").first.css("h4").text
      :location => doc.css(".card-text-container").first.css("p").text
      :profile_url => http://67.205.146.216:30000/fixtures/student-site/students/ryan-johnson.html
      doc.css("a.roster-cards-container").attribute("href").value

    }
=end

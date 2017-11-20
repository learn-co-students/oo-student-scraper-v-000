require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper



  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    @students = []
    doc.css(".student-card").each do |student| @students << {
        name: student.css(".student-name").text,
        location: student.css(".student-location").text,
        profile_url: student.css("a").attribute("href").value
      }
  end
  @students
end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    @student = {}

    @student[:profile_quote] = doc.css(".vitals-text-container").first.css("div").text
    @student[:bio] = doc.css(".description-holder").first.css("p").text

    doc.css(".social-icon-container a").each do |social|
      if social.attribute("href").value.include?("twitter")
        @student[:twitter] = social.attribute("href").value
      elsif social.attribute("href").value.include?("linkedin")
          @student[:linkedin] = social.attribute("href").value
      elsif social.attribute("href").value.include?("github")
            @student[:github] = social.attribute("href").value
        else
          @student[:blog] = social.attribute("href").value
  end

end
@student
end
end

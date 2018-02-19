require 'open-uri'
require 'pry'
class Scraper

# html = File.read('../fixtures/student-site/index.html')
# doc = Nokogiri::HTML(html)

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_array = []
    doc.css("div.roster-cards-container").each do |card|
      card.css("div.student-card a").each do |individual|
         name = individual.css("h4").text
         location = individual.css("p").text
         profile = individual.select {|nd| nd}[0][1]
         student_array << {:name => name, :location => location, :profile_url => profile}
      end
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    media_links = {}
    doc.css("div.social-icon-container").each do |link|
      media_links[:bio] = doc.css("div.description-holder p").text
      media_links[:profile_quote] = doc.css("div.profile-quote").text
        link.css("a").each do |i|
          if i.attributes["href"].value.include?("twitter")
            media_links[:twitter] = i.attributes["href"].value
          elsif i.attributes["href"].value.include?("linkedin")
            media_links[:linkedin] = i.attributes["href"].value
          elsif i.attributes["href"].value.include?("github")
            media_links[:github] = i.attributes["href"].value
          elsif i.attributes["href"].value.include?("http")
            media_links[:blog] = i.attributes["href"].value
          end
        end
      end
    media_links
  end


end

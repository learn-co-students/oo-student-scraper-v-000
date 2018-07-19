require 'open-uri'
require 'pry'
#collaboration with Brandon Green, Alicia Yu, Cory Veten, Maurice Argoetti, Heidi H
class Scraper

  def self.scrape_index_page(index_url)
    index_url = Nokogiri::HTML(open("./fixtures/student-site/index.html"))
    index_url.css(".student-card").map do |profile|
      {name: profile.css("h4.student-name").text,
      location: profile.css("p.student-location").text,
      profile_url: profile.css("a")[0]["href"]
      }
    end
  end

  def self.scrape_profile_page(profile_url)
    student = {}

    prof = Nokogiri::HTML(open(profile_url))

    links = prof.css(".social-icon-container a").collect {|icon| icon.attribute("href").value}
    links.each do |link|
    #profile_hash = {}
    #html = open(profile_url)
    #doc = Nokogiri::HTML(html)
    #student = doc.css("div .social-icon-container").children.css("a").map do |profile|
      #profile.attribute("href").value
        #student.each do |link|
          if link.include? ("twitter")
            student[:twitter] = link
          elsif link.include?("linkedin")
            student[:linkedin] = link
          elsif link.include?("github")
            student[:github] = link
          elsif link.include?(".com")
            student[:blog] = link
          end
        end
        student[:profile_quote] = prof.css(".profile-quote").text
        student[:bio] = prof.css("div.description-holder p").text
        student
      end
end

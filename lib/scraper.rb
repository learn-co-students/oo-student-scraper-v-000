require 'open-uri'
require 'pry'
require 'nokogiri'
#all cards: div.roster-cards-container
#names: div.card-text-container h4
# doc = Nokogiri::HTML(open("./fixtures/student-site/students/jenny-yamada.html"))
# binding.pry
class Scraper


  def self.scrape_index_page(index_url)
    results = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css("div.student-card").each do |container|
      results << {
        :name => container.css("h4").text,
        :location => container.css("p").text,
        :profile_url => container.css("a").attribute("href").value
      }
    end
    results
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    info = {
      :profile_quote => doc.css("div.profile-quote").text,
      :bio => doc.css("div.bio-content.content-holder p").text
    }
    doc.css('div.social-icon-container a').each do |soc|
      if soc.attribute("href").value.include?('github')
        info[:github] = soc.attribute("href").value
      elsif soc.attribute("href").value.include?('twitter')
        info[:twitter] = soc.attribute("href").value
      elsif soc.attribute("href").value.include?('linkedin')
        info[:linkedin] = soc.attribute("href").value
      else
        info[:blog] = soc.attribute("href").value
      end
    end
    info
  end

end

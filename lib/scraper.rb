require 'open-uri'
require 'pry'
class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    persons = doc.css("div.student-card")
    persons.collect {|person|
      hash = {name: person.css(".student-name").text, location: person.css(".student-location").text}
      hash[:profile_url] = "./fixtures/student-site/#{person.css("a").first["href"]}"
      hash
    }
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    hash = {}
    hash[:profile_quote] = doc.css(".profile-quote").text
    hash[:bio] = doc.css(".description-holder p").text

    social_acc = doc.css(".social-icon-container a")

    social_acc.each{ |acc|
      url = acc.attribute("href").value
      if url.match(/twitter/)
        hash[:twitter] = url
      elsif url.match(/github/)
        hash[:github] = url
      elsif url.match(/linkedin/)
        hash[:linkedin] = url
      else
        hash[:blog] = url
      end
    }
    hash
  end


  #       :twitter=>"http://twitter.com/flatironschool",
  #       :linkedin=>"https://www.linkedin.com/in/flatironschool",
  #       :github=>"https://github.com/learn-co,
  #       :blog=>"http://flatironschool.com",
  #       :profile_quote=>"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
  #       :bio=> "I'm a school"
end

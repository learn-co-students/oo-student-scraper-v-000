require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
  	doc = Nokogiri::HTML(open(index_url))

    doc.css(".student-card").map do |student|

      { :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }

    end
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    twitter_result = doc.css("a[href*=\"twitter\"]")
    linkedin_result = doc.css("a[href*=\"linkedin\"]")
    github_result = doc.css("a[href*=\"github\"]")
    blog_result = doc.css("a[href*=\"http:\"]")
    profile_quote_result = doc.css(".profile-quote")
    bio_result = doc.css(".description-holder p")

    student_hash = {
      :twitter => !twitter_result.empty? && twitter_result.attribute("href").value,
      :linkedin => !linkedin_result.empty? && linkedin_result.attribute("href").value,
      :github => !github_result.empty? && github_result.attribute("href").value,
      :blog => !blog_result.empty? && blog_result.attribute("href").value,
      :profile_quote => profile_quote_result.text,
      :bio => bio_result.text.split.join(" ")
    }

    student_hash.delete_if {|_,value| value == false}

    student_hash

  end
end

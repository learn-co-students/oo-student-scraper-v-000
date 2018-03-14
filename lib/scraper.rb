require 'open-uri'
require 'pry'


class Scraper


  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_array = []
    doc.css(".student-card").each do |card|
    student_hash = {
    :name => card.css(".student-name").text,
    :location => card.css(".student-location").text,
    :profile_url => card.css("a").attr("href").text
    }
    student_array<< student_hash
  end
    student_array
end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    hash= {} #twitter: "", linkedin: "", github: "", blog: "", profile_quote: "", bio: ""
    doc.css(".social-icon-container a"). each do |link|
      if link.attr("href").include?("twitter")
          hash[:twitter] = link.attr ("href")
      elsif link.attr("href").include?("linkedin")
          hash[:linkedin] = link.attr ("href")
      elsif link.attr("href").include?("github")
        hash[:github] = link.attr ("href")
      else
        hash[:blog] = link.attr("href")
        end
      end
      hash[:profile_quote] = doc.css("div.vitals-text-container div.profile-quote").text
      hash[:bio]= doc.css("div.bio-content p").text
      hash
end
end

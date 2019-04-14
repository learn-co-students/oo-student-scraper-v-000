require 'open-uri'
require "nokogiri"
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    # The return value of this method should be an array of hashes in which each
    # hash represents a single student. The keys of the individual student
    # hashes should be `:name`, `:location` and `:profile_url`
    html = open(index_url)
    doc = Nokogiri::HTML(html)

    doc.css(".student-card").collect do |studentcard|
        temp = {}
        temp[:name] = studentcard.css("a div h4").text
        temp[:location] = studentcard.css("a div p").text
        temp[:profile_url] = "./fixtures/student-site/" + studentcard.css("a").first["href"]
        temp
        # binding.pr
    end
  end

  def self.scrape_profile_page(profile_url)
      html = open(profile_url)
      doc = Nokogiri::HTML(html)

      temp = {}

      temp[:bio] =  doc.css("div.description-holder p").text
      temp[:profile_quote] = doc.css("div.profile-quote").text

      doc.css("div.social-icon-container a").each do |icon|
          if icon["href"].include?("github")
              temp[:github]=icon["href"]
          elsif icon["href"].include?("linkedin")
              temp[:linkedin]=icon["href"]
          elsif icon["href"].include?("twitter")
              temp[:twitter]=icon["href"]
          else
              temp[:blog]=icon["href"]
          end
      end

      temp
  end

end

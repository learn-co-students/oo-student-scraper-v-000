require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    index = Nokogiri::HTML(html)

    student_index_array = []

    index.css("div.student-card").each do |student_card|
      student_index_array << {
        :name => student_card.css("div.card-text-container h4.student-name").text,
        :location => student_card.css("div.card-text-container p").text,
        :profile_url => student_card.css("a").attr('href').value
      }
    end

    student_index_array

  end # end of scrape_index_page

  def self.scrape_profile_page(profile_url)

    html = File.read(profile_url)
    index = Nokogiri::HTML(html)

    profile = {}

    index.css("div.social-icon-container a").each do |link|
      #binding.pry
      social = link["href"]
      if social.include?("twitter")
        profile[:twitter] = social
      elsif social.include?("linkedin")
        profile[:linkedin] = social
      elsif social.include?("github")
        profile[:github] = social
      else
        profile[:blog] = social
      end
    end

    profile[:profile_quote] = index.css("div.profile-quote").text
    profile[:bio] = index.css("div.bio-content p").text
    #binding.pry
    profile
  end # end of scrape_profile_page

end

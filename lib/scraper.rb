require 'open-uri'
require 'pry'


class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    index_hash = doc.css(".student-card").map do |student|
      student_hash = {}
      student_hash[:name] = student.css(".student-name").text
      student_hash[:location] = student.css(".student-location").text
      student_hash[:profile_url] = student.css("a").attribute("href").value
      student_hash
    end
    index_hash
  end

  # def self.scrape_profile_page(profile_url)
  #   doc = Nokogiri::HTML(open(profile_url))
  #   profile_hash = doc.css(".social-icon-container a").map do |profile|
  #     #:twitter, :linkedin, :github, :blog, :profile_quote, :bio,
  #     social_hash = {}
  #     url = profile.attribute("href").text
  #
  #     if url.include?("twitter")
  #       social_hash[:twitter] = url
  #     elsif url.include?("linkedin")
  #       social_hash[:linkedin] = url
  #     elsif url.include?("github")
  #       social_hash[:github] = url
  #     elsif url.include?("facebook")
  #       social_hash[:facebook] = url
  #     else
  #       social_hash[:blog] = url
  #     end
  #     social_hash[:profile_quote] = profile.css(".profile-quote").text
  #     social_hash[:bio] = profile.css("p").text
  #   end
  #   profile_hash
  # end
  def self.scrape_profile_page(profile_url)
      get_page = Nokogiri::HTML(open(profile_url))

      student_profile = {
        :profile_quote => get_page.css(".profile-quote").text,
        :bio => get_page.css("p").text
      }

      get_page.css("div.social-icon-container a").each do |social|
        case social.at("img").attributes["src"].value
        when "../assets/img/twitter-icon.png"
          student_profile[:twitter] = social.attributes["href"].value
        when "../assets/img/linkedin-icon.png"
          student_profile[:linkedin] = social.attributes["href"].value
        when "../assets/img/github-icon.png"
          student_profile[:github] = social.attributes["href"].value
        when "../assets/img/rss-icon.png"
          student_profile[:blog] = social.attributes["href"].value
        end
      end
      student_profile
    end
end

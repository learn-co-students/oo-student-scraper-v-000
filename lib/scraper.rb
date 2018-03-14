require 'nokogiri'
require 'open-uri'
require 'pry'

# student = index.css("div.student-card")
# name: student.css("h4.student-name").text
# location: student.css("p.student-location").text
# profile_url: student.css("a").attribute("href").value


class Scraper

  def self.scrape_index_page(index_url)
    index = Nokogiri::HTML(open(index_url))

    students = []

    index.css("div.student-card").each do |student|
      students << {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => ("./fixtures/student-site/" + student.css("a").attribute("href").value)
      }
    end
    students
  end


#profile.css("div.social-icon-container a").attribute("href").value
  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))

    profile_info = {
      :profile_quote => profile.css("div.profile-quote").text,
      :bio => profile.css("div.bio-content div.description-holder p").text
    }

    profile.css("div.social-icon-container a").each do |social_icon|
      if social_icon.attribute("href").value.include?("twitter")
          profile_info[:twitter] = social_icon.attribute("href").value
        elsif social_icon.attribute("href").value.include?("linkedin")
          profile_info[:linkedin] = social_icon.attribute("href").value
        elsif social_icon.attribute("href").value.include?("github")
          profile_info[:github] = social_icon.attribute("href").value
        else
          profile_info[:blog] = social_icon.attribute("href").value
        end
      end

      profile_info

  end

end

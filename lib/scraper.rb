require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    studentSite = Nokogiri::HTML(html)

    students = []

    studentSite.css(".student-card").each do |student|
      students << {
        :name => student.css("a .card-text-container h4.student-name").text,
        :location => student.css("a .card-text-container p.student-location").text,
        :profile_url => "./fixtures/student-site/"+student.css("a").attribute("href").value
      }
    end

    return students

  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    profilePage = Nokogiri::HTML(html)

    profiles = {}

    twitter_url = ""
    linkedin_url = ""
    github_url = ""
    blog_url = ""

    profilePage.css(".vitals-container .social-icon-container a").each do |e|
      social_temp = e.attribute("href").value
      if social_temp.match(/twitter/)
        twitter_url = social_temp
      elsif social_temp.match(/linkedin/)
        linkedin_url = social_temp
      elsif social_temp.match(/github/)
        github_url = social_temp
      elsif social_temp.match(/youtube/)

      else
        blog_url = social_temp
      end
    end

    profile_quote = profilePage.css(".vitals-container .vitals-text-container .profile-quote").text
    bio = profilePage.css(".details-container .bio-block .description-holder p").text

    profiles[:twitter] = twitter_url if twitter_url != ""
    profiles[:linkedin] = linkedin_url if linkedin_url != ""
    profiles[:github] = github_url if github_url != ""
    profiles[:blog] = blog_url if blog_url != ""
    profiles[:profile_quote] = profile_quote
    profiles[:bio] = bio

    return profiles


  end

end

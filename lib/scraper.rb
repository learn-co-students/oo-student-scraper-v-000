require 'open-uri'
require 'nokogiri' #i added this
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read('fixtures/student-site/index.html')
    index_page = Nokogiri::HTML(html)

    all_projects = []
    projects = {}

    index_page.css("div.roster-cards-container").each do |project|
      project.css(".student-card a").each do |student|
          name = student.css(".student-name").text,
          location = student.css(".student-location").text,
          profile_url = student.attr("href")
          projects = { name: name[0], location: location, profile_url: profile_url }
          all_projects << projects
      end #iterating student
    end #iterating project
    all_projects
  end

  def self.scrape_profile_page(profile_url)
      html = File.read(open(profile_url))
      profile_page = Nokogiri::HTML(html)

      all_profiles = {}

      profile_page.css("div.social-icon-container a").each do |profile|

        link = profile.attribute("href").value

        if link.include?("twitter")
          all_profiles[:twitter] = link
        elsif link.include?("linkedin")
          all_profiles[:linkedin] = link
        elsif link.include?("github")
          all_profiles[:github] = link
        else
          all_profiles[:blog] = link
        end
      end #each
        profile_quote = profile_page.css(".profile-quote").text
        bio = profile_page.css(".details-container p").children.text
        all_profiles[:profile_quote] = profile_quote
        all_profiles[:bio] = bio

        all_profiles

    end #method

end #class

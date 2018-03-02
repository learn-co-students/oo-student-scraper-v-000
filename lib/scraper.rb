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


      profile_page.css("div.social-icon-container a").each do |profile|

        twitter = profile_page.css("div.social-icon-container a").attribute("href").value
        linkedin = profile_page.css("div.social-icon-container a")[1].attribute("href").value
        github = profile_page.css("div.social-icon-container a")[2].attribute("href").value
        blog = profile_page.css("div.social-icon-container a")[3].attribute("href").value
        profile_quote = profile_page.css(".profile-quote").text
        bio = profile_page.css(".details-container p").children.text

        all_profiles = {:twitter => twitter, :linkedin => linkedin, :github => github, :blog => blog, :profile_quote => profile_quote, :bio => bio}

        if profile_page.css("div.social-icon-container a").attribute("href").value
          all_profiles[:twitter] = twitter
        end
        if profile_page.css("div.social-icon-container a")[1].attribute("href").value
          all_profiles[:linkedin] = linkedin
        end
        if profile_page.css("div.social-icon-container a")[2].attribute("href").value
          all_profiles[:github] = github
        end
        if profile_page.css("div.social-icon-container a")[3].attribute("href").value
          all_profiles[:blog] = blog
        end
        if profile_page.css(".profile-quote").text
          all_profiles[:profile_quote] = profile_quote
        end
        if profile_page.css(".details-container p").children.text
          all_profiles[:bio] = bio
        end
        #binding.pry

      end
    end





end #class

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
          all_projects << {name: name[0], location: location, profile_url: profile_url }
      end #iterating student
    end #iterating project
    all_projects
  end


  def self.scrape_profile_page(profile_url)
    html = File.read(open(profile_url))
    profile_page = Nokogiri::HTML(html)

    profile_page.css("div.social-icon-container a").each do |icon|
      twitter = icon.attr("href") #twitter
      bio = profile_page.css(".details-container p").children.text #bio
      # linkedin
      # github
      # blog link

    end #each icon

    profile_page.css(".vitals-container a").each do |bio| #a
      linkedin = profile_page.css("div.social-icon-container a").attr("href").value #sometimes works, sometimes returns a twitter link
      #profile_page.css(".vitals-container a").css("a")
      binding.pry
    end

    profile_page.css(".vitals-text-container").each do |profile|
      profile_quote = profile.css(".profile-quote").text #profile quote
    end

  end

end

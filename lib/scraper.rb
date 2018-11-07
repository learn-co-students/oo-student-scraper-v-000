require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    scraped_students = []
    index_page = Nokogiri::HTML(open(index_url))
    index_page.css("div .roster-cards-container").each do |student_card|
      student_card.css(".student-card a").each do |student|
        profile_url = "./fixtures/student-site/#{student.attr("href")}"
        scraped_students << {:location => student.css(".student-location").text, :name => student.css(".student-name").text, :profile_url => profile_url}
      end
    end
        scraped_students
  end

  def self.scrape_profile_page(student_profile_url)
    links = {}
    student_profile = Nokogiri::HTML(open(student_profile_url))
    social_icons = student_profile.css("div.social-icon-container a").map {|link| link['href']}
    profile_quote = student_profile.css("div.vitals-text-container .profile-quote").text
    bio =  student_profile.css(".bio-content p").text
    twitter = social_icons.find {|icon| icon.include?("twitter")}
    linked_in = social_icons.find {|icon| icon.include?("linkedin")}
    github = social_icons.find {|icon| icon.include?("github")}
    blog = (social_icons.reject {|icon| icon.include?("https")}).first

    links[:twitter] = twitter unless !twitter
    links[:linkedin] = linked_in unless !linked_in
    links[:github] = github unless !github
    links[:blog] = blog unless !blog
    links[:profile_quote] = profile_quote
    links[:bio] = bio
    links
  end
end

require 'open-uri'
require 'pry'

class Scraper
  #name: index_page.css(".student-name").text or index_page.css("div.card-text-container h4.student-name").text
  #location: index_page.css(".student-location").text or index_page.css("div.card-text-container p.student-location").text
  #profile_url: index_page.css("div.student-card a").attribute("href").value

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []
    index_page.css("div.student-card").each do |student|
      students << {
        :name => student.css(".student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    # :twitter=>  profile_page.css("div.social-icon-container a").attribute("href").value
    # :linkedin=>  profile_page.css("div.social-icon-container a")[1].attribute("href").value
    # :github=>   profile_page.css("div.social-icon-container a")[2].attribute("href").value
    # :blog=>  profile_page.css("div.social-icon-container a")[3].attribute("href").value
    # :profile_quote=>  profile_page.css("div.profile-quote").text
    # :bio=>  profile_page.css("div.bio-content.content-holder div.description-holder p").text

    # Passed 1st test with the following code for #scrape_profile_page method

    # profile_page = Nokogiri::HTML(open(profile_url))
    # student_info = {}
    # profile_page.css("div.social-icon-container").each {|profile| student_info[:twitter] = profile.css("a").attribute("href").value}
    # profile_page.css("div.social-icon-container").each {|profile| student_info[:linkedin] = profile.css("a")[1].attribute("href").value}
    # profile_page.css("div.social-icon-container").each {|profile| student_info[:github] = profile.css("a")[2].attribute("href").value}
    # profile_page.css("div.social-icon-container").each {|profile| student_info[:blog] = profile.css("a")[3].attribute("href").value}
    # student_info[:profile_quote] = profile_page.css("div.profile-quote").text
    # student_info[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text
    # student_info

    #trying to refactor to pass 2nd test for #scrape_profile_page method

    profile_page = Nokogiri::HTML(open(profile_url))
    student_info = {}
    if profile_page.css("div.social-icon-container a").attribute("href").value
      profile_page.css("div.social-icon-container").each {|profile| student_info[:twitter] = profile.css("a").attribute("href").value}
    end
    if profile_page.css("div.social-icon-container a")[1].attribute("href").value
      profile_page.css("div.social-icon-container").each {|profile| student_info[:linkedin] = profile.css("a")[1].attribute("href").value}
    end

    if profile_page.css("div.social-icon-container a")[2].attribute("href").value
      profile_page.css("div.social-icon-container").each {|profile| student_info[:github] = profile.css("a")[2].attribute("href").value}
    end
    if profile_page.css("div.social-icon-container a")[3].attribute("href").value
      profile_page.css("div.social-icon-container").each {|profile| student_info[:blog] = profile.css("a")[3].attribute("href").value}
    end

    student_info[:profile_quote] = profile_page.css("div.profile-quote").text
    student_info[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text
    student_info
  end

end

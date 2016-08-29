require 'open-uri'
require 'pry'

class Scraper

  attr_accessor :name , :location , :profile_url

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    #binding.pry
    index_page.css(" .student-card").map do |student|
      student_hash = {:name => student.css(" .student-name").text, :location => student.css(" .student-location").text, :profile_url => "./fixtures/student-site/" + student.css("a").attribute("href").text}
    end


  end

  def self.scrape_profile_page(profile_url)
    html = Nokogiri::HTML(open(profile_url))

    social_array = html.css(" .vitals-container").css("a").map {|e| e.attribute("href").text  }

    twitter = social_array.grep(/.+twitter.+/).join
    linkedin = social_array.grep(/.+linkedin.+/).join
    github = social_array.grep(/.+github.+/).join
    blog = social_array.grep(/http:.*/).join


    profile_quote = html.css(" .profile-quote").text
    bio = html.css(" .description-holder").css("p").text

    profile_hash = {}

    profile_hash[:twitter] = twitter if twitter != ""
    profile_hash[:linkedin] = linkedin if linkedin != ""
    profile_hash[:github] = github if github != ""
    profile_hash[:blog] = blog if blog != ""
    profile_hash[:profile_quote] = profile_quote if profile_quote != ""
    profile_hash[:bio] = bio if bio != ""
    #binding.pry
    profile_hash
  end

end

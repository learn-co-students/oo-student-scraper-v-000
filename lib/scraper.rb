require_relative "../lib/student.rb"
require 'open-uri'
require 'pry'

class Scraper
 
# .scrape_index_page => 
#   top layer page scrape used to make new student, 
#   get attributes as array of indiv student hashes: 
#    [{:name => "Abby Smith",:location => "Brooklyn, NY",
#      :profile_url => "students/abby-smith.html"}, 
#     {:name => etc.} ]
  
  def self.scrape_index_page(index_url)
    # index_url = '.fixtures/student-site.index.html'
    doc = Nokogiri::HTML(File.read(index_url))
    student_index_array = doc.css('div.student-card').map do |student|
       {:name => student.css('h4').text, 
        :location => student.css('p').text,
        :profile_url => student.css('a').attribute('href').value}
     end
      student_index_array
  end    
 
# second layer scrape indiv student profile pages. 
# Add these attributes:
# :twitter, :linkedin, :github, :blog, :profile_quote, :bio
  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(File.read(profile_url))
      # social_icons = []
      social_icons = profile.css("div.social-icon-container")
      quote = profile.css("div.profile-quote")
      bio = profile.css("div.bio-content content-holder")
      # social_icons << icon.css('a').attribute('href').value.include?('twitter')
      # p social_icons
  end
    #   {
    #     :twitter => 
    #     :linkedin => icon.css('')  , 
    # :github    =>   , 
    # :blog =>        , 
    # :profile_quote =>  ,
    # } 
    #  p profile_url.css('.bio-block.details-block p').text

  #    {:bio => "test" 
  #   }
  #   end
  # end
# 
end # class end

require_relative "../lib/student.rb"
require 'open-uri'
require 'pry'

class Scraper
 
# .scrape_index_page => 
#   top layer page scrape grabs 3 attributes from 
#   all students; will be used to make each student object, 
#   attributes saved as array of indiv student hashes: 
#    [{:name => "Abby Smith",:location => "Brooklyn, NY",
#      :profile_url => "students/abby-smith.html"}, 
#     {:name => etc.} ]
  
  def self.scrape_index_page(index_url)
    # index_url = '.fixtures/student-site.index.html'
    doc = Nokogiri::HTML(File.read(index_url))
    doc.css('div.student-card').map do |student|
      {:name => student.css('h4').text, 
       :location => student.css('p').text,
       :profile_url => student.css('a').attribute('href').value}
     end
  end    
 
# second layer scrape indiv student profile pages. 
# Add these attributes:
# :twitter, :linkedin, :github, :blog, :profile_quote, :bio
  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(File.read(profile_url))
    attributes = {}
    social = profile.css('div.social-icon-container')
      social_info = social.css('a').attribute('href').each do |ref|
        if ref.value.include?('twitter')
          attributes[:twitter] = social_info
        elsif ref.value.include?('linkedin')
          attributes[:linkedin] = social_info
        elsif ref.value.include?('github')
          attributes[:github] = social_info      
        elsif ref.value.include?('github')
          attributes[:blog] = social_info
        end
      binding.pry
      end  
    attributes[:profile_quote] = profile.css("div.profile-quote").text
   # attributes[:bio] = 
    test = profile.css("div.bio-content.content-holder")#.children.each {|child| 'p').text

    #attributes
  end
  
end # class end

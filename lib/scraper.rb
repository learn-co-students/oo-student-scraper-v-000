require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    @index_doc = Nokogiri::HTML(open(index_url))
    students = @index_doc.search("div.student-card").collect do |student|
      {
        :name => student.search("h4.student-name")[0].text,
        :location => student.search("p.student-location")[0].text,
        :profile_url => student.search("a")[0].attribute("href").value
      }
    end
  end
  
 

  def self.scrape_profile_page(profile_url)
    @profile_doc = Nokogiri::HTML(open(profile_url))
    
    profile = {
      :bio => @profile_doc.search("div.details-container div.description-holder p").text,
      :profile_quote => @profile_doc.search("div.profile-quote").text
    }
    
    social_urls = []
    @profile_doc.search("div.social-icon-container")[0].children.each_with_index{|node, index| social_urls.push(node.attributes['href'].value) if index.odd?}
    
    social_urls.each do |url|
      profile[:twitter] = url if url.include?("twitter")
      profile[:linkedin] = url if url.include?('linkedin')
      profile[:github] = url if url.include?('github')
      profile[:blog] = url if !profile.has_value?(url)
    end
    
    profile
  end

end


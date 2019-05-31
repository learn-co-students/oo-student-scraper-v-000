require_relative "../lib/student.rb"

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
    attributes = {}
    profile = Nokogiri::HTML(File.read(profile_url))
      social = profile.css('div.social-icon-container').children
        social.css('a').each do |a| ref = a.attribute('href').value
          if ref.include?('twitter')
            attributes[:twitter] = ref
          elsif ref.include?('linkedin')
            attributes[:linkedin] = ref
          elsif ref.include?('github')
            attributes[:github] = ref
          elsif ref 
            attributes[:blog] = ref
          end
          attributes[:profile_quote] = profile.css("div.profile-quote").text
          attributes[:bio] = profile.css("div.bio-content.content-holder").children.css('p').text
        end
      attributes
  end
end # class end

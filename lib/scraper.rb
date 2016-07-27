require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
        doc = Nokogiri::HTML(open(index_url))
        students = []
            doc.css('.student-card').each do |student|
                students <<    {name: student.css(".student-name").text, 
                                location: student.css(".student-location").text, 
                                profile_url: index_url + student.css('a').attribute('href').value} 
                   
            end  
         students  
  end

  def self.scrape_profile_page(profile_url)
     doc = Nokogiri::HTML(open(profile_url))
      # student profile  hash with quote and bio
      student_profile = 
        {
        :profile_quote=> doc.css('.profile-quote').text,
        :bio=> doc.css('.bio-content').css('.description-holder').css('p').text
        } 
        #socail media links of profile
       links = doc.css('.social-icon-container')[0].css('a')
       # iterates through social media links and creates hash according to social icon match
             links.each{|link|
                          if link.children.attribute('src').value == "../assets/img/linkedin-icon.png" 
                              student_profile[:linkedin] = link.attribute('href').value
                          elsif link.children.attribute('src').value == "../assets/img/twitter-icon.png"
                              student_profile[:twitter] = link.attribute('href').value
                          elsif link.children.attribute('src').value == "../assets/img/github-icon.png"
                              student_profile[:github] = link.attribute('href').value
                          elsif link.children.attribute('src').value == "../assets/img/rss-icon.png"
                              student_profile[:blog] = link.attribute('href').value
                          end       
                       }
        # Return Student profile hash                    
        student_profile

  end

end


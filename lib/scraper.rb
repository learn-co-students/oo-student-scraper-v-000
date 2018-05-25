require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_html = open(index_url)
    doc = Nokogiri::HTML(index_html)
    student_cards = doc.css('.student-card')
    student_info = []
    student_cards.collect do |roster|
      student_info << {
        :name => roster.css('.student-name').first.inner_text,
        :location => roster.css('.student-location').first.inner_text,
        :profile_url => roster.css('a').attribute("href").value
      }
    end
    student_info
  end

  def self.scrape_profile_page(profile_url)
    profile_html = open(profile_url)
    p_doc = Nokogiri::HTML(profile_html)
    student_profile = {}
    p_doc.css('div.social-icon-container a').each do |links|
      case links.attribute("href").value 
      when /twitter/
        student_profile[:twitter] = links.attribute("href").value
      when /linkedin/
        student_profile[:linkedin] = links.attribute("href").value
      when /github/
        student_profile[:github] = links.attribute("href").value
      else /blog/
        student_profile[:blog] = links.attribute("href").value
      end
    end 
    student_profile[:profile_quote] = p_doc.css(".profile-quote").text
    student_profile[:bio] = p_doc.css('div.bio-content div.description-holder').text.strip
    student_profile
   end 
  end


 	 



# doc.css('.student-card').css('.student-name').first.inner_text .attr('.h4')
# doc.css('.student-card').css('.student-location').first.inner_text .attr('.p')
# doc.css('roster-cards-container') .attr('.href')
#('.card-text-container') => name; location
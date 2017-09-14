require 'open-uri'
require 'Nokogiri'
require 'pry'

class Scraper




  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    scraper = Nokogiri::HTML(html)

    #projects = []

      scraper.css('.roster-cards-container a').collect do |info|
         project = {
          :name => info.css('.student-name').text,
          :location => info.css('.student-location').text,
          :profile_url => info.attribute('href').value
        }
    #    projects << project
      end
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    scraper = Nokogiri::HTML(html)

    student_info = {}
      scraper.css('body').each do |info|
          info.css('.social-icon-container a').each do |link|
            link_text = link.attribute('href').value
            if link_text.include?("twitter")# check if it's a twitter link
              student_info[:twitter] = link.attribute('href').value
            elsif link_text.include?("linkedin")#check if it's a linkedin link
              student_info[:linkedin] = link.attribute('href').value
            elsif link_text.include?("github")#check if it's a github link
              student_info[:github] = link.attribute('href').value
            else
              student_info[:blog] = link.attribute('href').value
            end
          end

          student_info[:profile_quote] = info.css('.profile-quote').text
          student_info[:bio] = info.css('.description-holder p').inner_html
       end
       student_info
      end


    # Social link = scraper.css('.social-icon-container a').attribute('href').value
  end

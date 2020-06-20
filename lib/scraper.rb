require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    #open
    doc = Nokogiri::HTML(open(index_url))
    #create output_array
    student_index_array = Array.new
    #iterate over element to scrape students info
    doc.css('div.student-card').each do |index|
      #first set variable equal to values
      student_name = "#{index.css('.student-name').text}"
      student_location = "#{index.css('.student-location').text}"
      student_profile_url = "#{index.css('a').attr('href').text}"
      #.push hash notation into array
      student_index_array.push({:name => student_name, :location => student_location, :profile_url => student_profile_url})
#binding.pry
    end
  student_index_array
#binding.pry
  end

  def self.scrape_profile_page(profile_url)
    #open html
    profile_hash = Hash.new
    doc = Nokogiri::HTML(open(profile_url))
    #doc.css(".social-icon-container").css('a').attr('href')
    profile_links = doc.css(".social-icon-container").css('a').collect {|element| element.attr('href')}
    #Iterate over this array of links
      profile_links.each do |link|
        if link.include?("twitter")
          profile_hash[:twitter] = "#{link}"
        elsif link.include?("github")
          profile_hash[:github] = "#{link}"
        elsif link.include?("linkedin")
          profile_hash[:linkedin] = "#{link}"
        elsif link.include?("http")
          profile_hash[:blog] = "#{link}"
        end
      end

        profile_bio = doc.css(".description-holder").css('p')
        profile_bio.collect do |bio|
          profile_hash[:bio] = "#{bio.text}"
        end

          profile_quote = doc.css(".profile-quote")
          profile_quote.collect do |quote|
            profile_hash[:profile_quote] = "#{quote.text}"
          end
      profile_hash
  end


end

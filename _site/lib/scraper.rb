require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)

    @students = {}

    url = index_url<<"fixtures/student-site/"
    doc = Nokogiri::HTML(open(url))
    roster = doc.css("div.roster-cards-container div.student-card")
    
    counter = 1
    roster.each do |student|
      name =  student.css("div.card-text-container h4.student-name").text
      location = student.css("div.card-text-container p.student-location").text
      profile_url = "http://127.0.0.1:4000/" + student.css("a").attribute("href").text
      count = counter.to_s
      @students[count.to_sym] = {
      :name => name,
      :location => location,
      :profile_url => profile_url
      }
      counter += 1

    end
    @array = @students.collect {|key,value| value}
    @array  
  end

  def self.scrape_profile_page(profile_url)

    @info = {}

    doc = Nokogiri::HTML(open(profile_url))
    
    
    social = doc.css("div.social-icon-container a")

    social.each do |icon|
      
      if icon.attribute("href").value.include?("twitter")
        @info[:twitter] = icon.attribute("href").value
      elsif icon.attribute("href").value.include?("linked")
        @info[:linkedin] = icon.attribute("href").value
      elsif icon.attribute("href").value.include?("git")
        @info[:github] = icon.attribute("href").value
      elsif icon.attribute("href").value != nil
        @info[:blog] = icon.attribute("href").value
      end
    end

    @info[:profile_quote] = doc.css("div.vitals-text-container div.profile-quote").text

    @info[:bio] = doc.css("div.bio-content div.description-holder p").text 
    @info 


  end

end


require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    roster = []
    page = open(index_url)
    doc = Nokogiri::HTML(page)
    students = doc.css(".student-card")

    students.each do |student|
      roster << {:name => student.at(".student-name").text,
        :location => location = student.at(".student-location").text,
        :profile_url => profile_url = student.at("a").attributes['href'].value}
      end
    roster
  end

  def self.scrape_profile_page(profile_url)
    profiles = {}
    profile = open(profile_url)
    doc = Nokogiri::HTML(profile)
    quote = []
    social = doc.css(".social-icon-container a")
      social.each do
        |kid|  value = kid.attributes['href'].value
        case value
        when /linkedin/
          @linkedin = value
        when /twitter/
          @twitter = value
        when /github/
          @github = value
        else
          @blog = value
        end
    end

    @quote = doc.css(".profile-quote").text
    @bio = doc.css(".description-holder p").text

    profiles.tap do |hash|
      hash[:twitter] = @twitter if @twitter !=nil
      hash[:linkedin] = @linkedin if @linkedin !=nil
      hash[:github] = @github if @github !=nil
      hash[:blog] = @blog
      hash[:profile_quote] = @quote
      hash[:bio] = @bio

    end

    profiles
  end
end

#iterate through url's
#social.each {|kid| puts kid.attributes['href'].value}

  #1. get into student data
  #2. establish a temporary variable to store each value while iterating through
  #3. If .attributes['href'].value includes -- twitter, linkedin, github  == store that value in that variable
      #case statement for this?
  #4. target bio directly
  #5. 2-part process for quote.  Target quote, store in array.  target author of quote, store in array.
      #--> combine array into string and store in variable
  #6. put all these items into hash array
    # student.each do |entry|
    #   binding.pry
    #   profile = student.at(".social-icon-container a")
    #   profile.each {|val| puts val}

# .attributes['href'].value

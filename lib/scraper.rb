require 'open-uri'
require 'pry'

require 'nokogiri' # remove later

class Scraper

  @students_array = []

  def self.scrape_index_page(index_url)

    doc = Nokogiri::HTML(open(index_url))
    students = doc.css(".student-card")

    students.each do |student|
      hash = {:name => nil, :location => nil, :profile_url => nil}
      hash[:name] = student.css(".student-name").text
      hash[:location] = student.css(".student-location").text
      hash[:profile_url] = student.css("a")[0]["href"]
      @students_array << hash
    end

    @students_array

  end


  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    @profile_hash = {:twitter => nil, :linkedin => nil, :github => nil, :blog => nil, :profile_quote => nil, :bio => nil}

# pull url text from any .css("a")
    student_profile = doc.css(".vitals-container")
    social_info = student_profile.css("div.social-icon-container")

    social_info.css("a").each do |code|
      if code["href"].match(/(twitter)/)
        @profile_hash[:twitter] = code["href"]
      elsif code["href"].match(/(linkedin)/)
        @profile_hash[:linkedin] = code["href"]
      elsif code["href"].match(/(github)/)
        @profile_hash[:github] = code["href"]
      else
        @profile_hash[:blog] = code["href"]
      end

    end

# pull quote text
    @profile_hash[:profile_quote] = doc.css('div.profile-quote').text

# pull bio text
     @profile_hash[:bio] = doc.css("div.description-holder p").text

# remove any nil keys
     hash = @profile_hash
     hash.each do |key, value|
       if value == nil
         hash.delete(key)
       end
     end

     @profile_hash

  end

  def all
    @students_array
  end
  
end

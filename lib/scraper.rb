require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = doc.css(".student-card a")
    student_array = students.collect {|student| "#{student.css(".student-name").text}: #{student.css(".student-location").text}: ./fixtures/student-site/#{student["href"]}"}
    refined_student_array = student_array.collect {|student| student.split(":").collect {|element| element.to_s.strip}}
    refined_student_array.collect do |name, location, profile_url|
      @student_info = {:name => nil, :location => nil, :profile_url => nil}
      @student_info[:name] = name
      @student_info[:location] = location
      @student_info[:profile_url] = profile_url
      @student_info
    end
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    profile = doc.css("body")
    social = profile.css("div.social-icon-container a").collect {|element| element["href"]}
    @profile_info = {}
    if social.find{|element| element.include?("twitter")}
      @profile_info[:twitter] = social.find{|element| element.include?("twitter")}
    else
      false
    end

    if social.find{|element| element.include?("linkedin")}
      @profile_info[:linkedin] = social.find{|element| element.include?("linkedin")}
    else
      false
    end

    if social.find{|element| element.include?("github")}
      @profile_info[:github] = social.find{|element| element.include?("github")}
    else
      false
    end

    social.find do |element|
      if element.include?("linkedin") == false && element.include?("twitter") == false && element.include?("github") == false
        @profile_info[:blog] = element
      else
        false
      end
    end
    @profile_info[:profile_quote] = profile.css(".profile-quote").text
    @profile_info[:bio] = profile.css("p").text
    @profile_info
  end

end

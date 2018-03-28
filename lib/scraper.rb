require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    # base = './fixtures/student-site/index.html'
    index = Nokogiri::HTML(open(index_url))

    index.css('a').collect do |student|
      # next if student.css('.student-name').text == ""
      {name: student.css('.student-name').text,
      location: student.css('.student-location').text,
      profile_url: student.attribute('href').text}
    end.slice(1..-1)
    # binding.pry

    # return value should be an array of hashes
    # each hash represent a single student
    # each hash is made up of :name, :location, and :profile_url

    # student's name: index.css('.student-name').each {|x| x.text}
    # student's location: index.css('.student-location').each {|x| x.text}
    # student's url: index.css('a').collect {|x| x.attribute('href').to_s}

  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    sm_links = profile.css('a').collect{|link| link.attribute('href').text}.slice(1..-1)
    student_profile = {}

    sm_links.each do |link|
      if link.include?("twitter")
        student_profile[:twitter] = link
      elsif link.include?("linkedin")
        student_profile[:linkedin] = link
      elsif link.include?("github")
        student_profile[:github] = link
      else
        student_profile[:blog] = link
      end
    end
    student_profile[:profile_quote] = profile.css('.profile-quote').text
    # binding.pry
    student_profile[:bio] = profile.css('div.description-holder p').text
    student_profile
  end

end

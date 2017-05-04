require 'nokogiri'
require 'open-uri'
require 'pry'


class Scraper

attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  def self.scrape_index_page(index_url)

    doc = Nokogiri::HTML(open(index_url))
      students = []

      doc.css('.student-card').each do |student|
      name = student.children.css('h4').first.text
      location = student.children.css('p').first.text
      profile_url = "./fixtures/student-site/#{student.children.css('a').first.attributes['href'].value}"

      students.push({name: name, location: location, profile_url: profile_url})
    end
    students
  end

  def self.scrape_profile_page(profile_url)

    doc = Nokogiri::HTML(open(profile_url))

    student_hash = {}

    doc.css('.social-icon-container a').each do |link|
      social_link = link.attributes['href'].value
      if social_link.include?('twitter')
        student_hash[:twitter] = social_link
      elsif social_link.include?('linkedin')
        student_hash[:linkedin] = social_link
      elsif social_link.include?('github')
        student_hash[:github] = social_link
      else
        student_hash[:blog] = link.attributes['href'].value
      end

    end

    !doc.css('.profile-quote').nil? ? student_hash[:profile_quote] = doc.css('.profile-quote').text : nil
    #.each do |quote|

    !doc.css('.description-holder').nil? ? student_hash[:bio] = doc.css('.description-holder').children[1].text : nil

  student_hash
end

end

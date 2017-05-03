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

    doc.css('.social-icon-container').each do |link|

      twitter = doc.children.css('.social-icon-container').children[1].attributes['href'].value,
      linkedin = doc.children.css('.social-icon-container').children[3].attributes['href'].value,
      github = doc.children.css('.social-icon-container').children[5].attributes['href'].value,
      blog = doc.children.css('.social-icon-container').children[7].attributes['href'].value

      
        student_hash[:twitter] = twitter[0]

        student_hash[:linkedin] = linkedin

        student_hash[:github] = github

        student_hash[:blog] = blog

    end

    doc.css('.profile-quote').each do |quote|
      profile_quote =  doc.css('.profile-quote').children.text

      student_hash[:profile_quote] = profile_quote

    end

    doc.css('.description-holder').each do |description|
      bio = doc.css('.description-holder').children[1].text

      student_hash[:bio] = bio
  end
  student_hash
end

end

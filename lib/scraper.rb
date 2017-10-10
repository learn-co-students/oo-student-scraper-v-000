require 'nokogiri'
require 'open-uri'
require 'pry'
# names = doc.css("h4.student-name").text
# locations = doc.css("p.student-location").text
# profile_url = doc.css("a").collect {|i| i.attribute("href").value}.collect {|url| "./fixtures/student-site/#{url}"}
class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css("div.student-card a").collect do |student|
      students << {:name => "#{student.css("h4.student-name").text}",
      :location => "#{student.css("p.student-location").text}",
      :profile_url => "./fixtures/student-site/#{student.attr('href')}" }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    a = {}
    doc.css("div.social-icon-container a").each do |link|
      val = link.attributes["href"].value
      case
      when val.include?("github.com")
        a[:github] = val
      when val.include?("twitter.com")
        a[:twitter] = val
      when val.include?("linkedin.com")
        a[:linkedin] = val
      else
        a[:blog] = val
      end
    end
    a[:profile_quote] = "#{doc.css("div.profile-quote").text}"
    a[:bio] = "#{doc.css("div.description-holder p").text}"
    a
  end

end

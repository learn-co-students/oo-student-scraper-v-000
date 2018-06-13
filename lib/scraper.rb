require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students_array = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css("div.student-card").each do |c|
      student = Hash.new
      student[:name] = c.css("h4.student-name").text
      student[:location] = c.css("p.student-location").text
      student[:profile_url] = c.css("a[href]").first['href']
      students_array << student
    end
    students_array
  end

  def self.scrape_profile_page(profile_url)
    # The return value of this method should be a hash
    # in which the key/value pairs describe an individual student.
    # Some students don't have a twitter or some other social link.
    # Be sure to be able to handle that.
    doc = Nokogiri::HTML(open(profile_url))

    student = Hash.new
    # doc.xpath("/html/body/div[1]/div[2]/div[2]/a[1]")
    # ==> twitter
    student[:twitter] = doc.xpath("/html/body/div[1]/div[2]/div[2]/a[1]").attribute('href').value
    student[:linkedin] = doc.xpath("/html/body/div[1]/div[2]/div[2]/a[2]").attribute('href').value
    student[:github] =
    student[:blog] =
    student[:profile_quote] =
    student[:bio] =

  end

end

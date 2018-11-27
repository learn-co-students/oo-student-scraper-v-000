require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  attr_accessor :student_hashes, :bio, :quote, :twitter, :linkedin, :github, :blog, :student_hashe
  @student_hashes = []



  def self.scrape_index_page(index_url)

    doc = Nokogiri::HTML(open("#{index_url}"))
    students = doc.css("a")
    students.each do |card|
      a = card.css("h4").text
      b = card.css("p").text
      c = a.gsub(' ', '-').downcase
      e = "students/#{c}.html"
      d = {}

      d[:name] = a
      d[:location] = b
      d[:profile_url] = e
      @student_hashes << d
    end
    @student_hashes.delete_at(0)
    @student_hashes
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open("#{profile_url}"))
    student_hash = {}


      bio = doc.css("p").text
      quote = doc.css("div")[6].text

    doc.css("a").each do |x|
      if x["href"].include?("twitter")
        student_hash[:twitter] = x["href"]
      elsif x["href"].include?("github")
        student_hash[:github] = x["href"]
      elsif x["href"].include?("linkedin")
        student_hash[:linkedin] = x["href"]
      elsif x["href"].include?("http") && !x["href"].include?("twitter") && !x["href"].include?("github") && !x["href"].include?("linkedin")
        student_hash[:blog] = x["href"]
      end
    end


    if bio
      student_hash[:bio] = bio
    end
    if quote
      student_hash[:profile_quote] = quote
    end
    student_hash

  end

end

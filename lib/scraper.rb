require 'open-uri'
require 'pry'

class Scraper
  attr_accessor :name, :location, :profile_url, :twitter, :linkedin, :blog, :github

  def initialize(index_url)
    @doc = Nokogiri::HTML(open(index_url))
  end

  def self.scrape_index_page(index_url)
    @doc = Nokogiri::HTML(open(index_url))
    @box ||= @doc.search(".student-card")
    students = []
      @box.each do |student|
        student_hash = {
            :name =>  student.search("h4").text,
            :location => student.search("p").text,
            :profile_url => student.search("a").attribute("href").value,
          }
          students << student_hash
        end
    students
  end


    def self.scrape_profile_page(profile_url)
      profile = Nokogiri::HTML(open(profile_url))
      student_hash = {}
      student_hash[:profile_quote] = profile.search(".profile-quote").text
      student_hash[:bio] = profile.search("p").text
      profile.search(".social-icon-container a").each do |type|
        link = type.attr("href")
          if link.include? "twitter"
            student_hash[:twitter] = link
          elsif link.include? "linkedin"
            student_hash[:linkedin] = link
          elsif link.include? "github"
            student_hash[:github] = link
          else
            student_hash[:blog] = link
          end
        end
      student_hash
    end

    def self.scrape_from_hash(attributes_hash)
# take in a hash of attributes and set those equal to a symbol/key in a new hash
# this provides the translation between the incoming set of key/values and the ones that I actaully care about and need to use
    end

end

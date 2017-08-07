require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card").collect do |a|
      scraped_students = {
        :name => a.css(".student-name").text,
        :location => a.css(".student-location").text,
        :profile_url => a.css("a").attribute("href").value
      }
    end
  end

  def self.scrape_profile_page(profile_url)
    student_hash = {}
    doc = Nokogiri::HTML(open(profile_url))

    #----- Social Media Links (first iteration) -----
    #outer_most_code = doc.css(".social-icon-container")
    #array_inside = a.css("a")
    #------ inside the array (second iteration) ------
    #each_link = b.attribute("href").value
    #social_media_word =
      #social_icon = b.children[0].attribute("src").value
      #social_icon[14, social_icon.length-1].split("-")[0]

    doc.css(".social-icon-container").map do |a|
      a.css("a").map do |b|
        binding.pry
        #b.attribute("href").value #link
        social_icon = b.children[0].attribute("src").value
        key = social_icon[14, social_icon.length-1].split("-")[0]
        value = b.attribute("href").value
        student_hash = {
          :"#{key}" => "#{value}"
        }

      end
    end
    student_hash
  end

end

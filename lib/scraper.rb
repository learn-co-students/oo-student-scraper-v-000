require 'open-uri'
require 'pry'

class Scraper
  
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    
    scraped_students = []
    
    doc.search(".student-card").each do |student|
      info = { 
        name: student.search(".student-name").text, 
        location: student.search(".student-location").text,
        profile_url: 
          student.search("a").map do |link|
            link.attribute('href').to_s
          end.uniq.sort.delete_if {|href| href.empty?}.join
      }
      scraped_students << info
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))

    # scraped_student = {
    #   bio: profile.search(".bio-block .description-holder p").text,

    #   blog: profile_url,

    #   github: "",

    #   linkedin: "",

    #   profile_quote: profile.search(".profile-quote").text,

    #   twitter: ""
    # }
    scraped_student = {
      
    }
    profile.search(".social-icon-container a").each do |link|
      if link.attribute('href').include? "github.com"
        binding.pry
        link.attribute('href').to_s
      elsif link.attribute('href').include? "linkedin.com"

      end
    end
    hash[:key] = "value"
    scraped_student
  end

end


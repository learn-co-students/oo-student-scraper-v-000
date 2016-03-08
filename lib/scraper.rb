require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_array = []
    doc = Nokogiri::HTML(open(index_url))

    doc.search("div.student-card").each do |student|
      new_student = {:name => student.search("h4.student-name").text,
                     :location => student.search("p.student-location").text,
                     :profile_url => index_url+student.search("a").attribute("href").value
                    }
      student_array << new_student
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    scraped_student = {:profile_quote => doc.search("div.profile-quote").text,
                       :bio => doc.search("div.description-holder p").text
                      }

    doc.search("div.social-icon-container a").each do |link|
      url = link.attribute("href").value

      if url.include?("twitter")
        scraped_student[:twitter] = url
      elsif url.include?("linkedin")
        scraped_student[:linkedin] = url
      elsif url.include?("github")
        scraped_student[:github] = url
      else
        scraped_student[:blog] = url
      end
    end
    scraped_student
  end

end

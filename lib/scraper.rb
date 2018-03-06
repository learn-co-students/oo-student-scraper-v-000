require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

      doc = Nokogiri::HTML(open(index_url))
      scraped_students_array = []

      doc.css(".student-card a").each do |i|

        student = {name: i.css(".student-name").text,
          location: i.css("p.student-location").text,
          profile_url: i.attr("href")}
          scraped_students_array.push(student)
        end
        scraped_students_array
      end

      def self.scrape_profile_page(profile_url)
          student = {}

          doc = Nokogiri::HTML(open(profile_url))
          doc.css(".social-icon-container a").each do |link|
            url = link.attributes["href"].value

            case
              when url.include?("twitter")
                  student[:twitter] = url
              when url.include?("linkedin")
                  student[:linkedin] = url
              when url.include?("github")
                  student[:github] = url
              else student [:blog] = url
            end


                  student [:profile_quote] = doc.css(".profile-quote").text
                  student [:bio] = doc.search(".description-holder p").text



    end
    student
  end
end

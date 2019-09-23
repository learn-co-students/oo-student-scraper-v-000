class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []
    index_page.css(".roster-cards-container").each { |card|
       card.css(".student-card a").each { |student|
         student_profile = "#{student.attr('href')}"
         student_location = student.css('.student-location').text
         student_name = student.css('.student-name').text
         students << {name: student_name, location: student_location, profile_url: student_profile}
       }
     }
     students
   end

   def self.scrape_profile_page(profile_url)
   profile_page = Nokogiri::HTML(open(profile_url))
   student = {}
   profile_links = profile_page.css(".social-icon-container").children.css("a").map { |e| e.attribute('href').value}

   profile_links.each do |link|
         if link.include?("linkedin")
           student[:linkedin] = link
         elsif link.include?("github")
           student[:github] = link
         elsif link.include?("twitter")
           student[:twitter] = link
         else
           student[:blog] = link
         end
       end
       student[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")
       student[:bio] = profile_page.css(".description-holder p").text if profile_page.css(".description-holder p")

       student
     end
end

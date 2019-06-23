## Worked on by Maurice Argoetti, Srija Kumar and Brandon Green, Lynie McClimon, Heidi Hlavinka
## PAIR PROGRAMMING FTW

class Scraper
  def self.scrape_index_page(index_url)
  profiles = []

  ind = Nokogiri::HTML(open(index_url))
  students = ind.css(".student-card")

  students.each do |profile|
    name = profile.css(".student-name").text
    location = profile.css(".student-location").text
    profile_url = profile.css("a").attribute("href").value
    profiles << {name: name,
      location: location,
      profile_url: profile_url}
      #binding.pry
  end
  profiles
  #binding.pry
end


  def self.scrape_profile_page(profile_url)
    student = {}

    prof = Nokogiri::HTML(open(profile_url))

    links = prof.css(".social-icon-container a").collect {|icon| icon.attribute("href").value}
    links.each do |link|
      if link.include?("twitter")
        student[:twitter] = link
      elsif link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include?(".com")
        student[:blog] = link
      end
      #binding.pry
    end
    student[:profile_quote] = prof.css(".profile-quote").text
    student[:bio] = prof.css("div.description-holder p").text
    student
  end

end
# def self.scrape_profile_page(profile_url)
#       page = Nokogiri::HTML(open(profile_url))
#       student = {}
#
#       # student[:profile_quote] = page.css(".profile-quote")
#       # student[:bio] = page.css("div.description-holder p")
#       container = page.css(".social-icon-container a").collect{|icon| icon.attribute("href").value}
#       container.each do |link|
#         if link.include?("twitter")
#           student[:twitter] = link
#         elsif link.include?("linkedin")
#           student[:linkedin] = link
#         elsif link.include?("github")
#           student[:github] = link
#         elsif link.include?(".com")
#           student[:blog] = link
#         end
#         binding.pry
#       end

#   end

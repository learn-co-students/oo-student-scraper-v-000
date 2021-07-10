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
    doc = Nokogiri::HTML(open(profile_url))

    student_hash = Hash.new

    # # Some students don't have a twitter or some other social link.
    # # Be sure to be able to handle that.
    # this is a bit hard-coded :(
    social_count = doc.xpath("/html/body/div[1]/div[2]/div[2]/a").count

    case social_count
    when 2
      student_hash = {
        linkedin: doc.xpath("/html/body/div[1]/div[2]/div[2]/a[1]").attribute('href').value,
        github: doc.xpath("/html/body/div[1]/div[2]/div[2]/a[2]").attribute('href').value,
        profile_quote: doc.xpath("/html/body/div[1]/div[2]/div[3]/div").text,
        bio: doc.xpath("//p").text
      }
    else
      student_hash = {
        twitter: doc.xpath("/html/body/div[1]/div[2]/div[2]/a[1]").attribute('href').value,
        linkedin: doc.xpath("/html/body/div[1]/div[2]/div[2]/a[2]").attribute('href').value,
        github: doc.xpath("/html/body/div[1]/div[2]/div[2]/a[3]").attribute('href').value,
        blog: doc.xpath("/html/body/div[1]/div[2]/div[2]/a[4]").attribute('href').value,
        profile_quote: doc.xpath("/html/body/div[1]/div[2]/div[3]/div").text,
        bio: doc.xpath("//p").text
      }
    end

    student_hash
  end

  # Here is a much more elegant version!
  # Check out the .children modifier
  # and the if link.include?() option,
  # and the if (thing returns true) option:

  # def self.scrape_profile_page(profile_slug)
  #   student = {}
  #   profile_page = Nokogiri::HTML(open(profile_slug))
  #   links = profile_page.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}
  #   links.each do |link|
  #     if link.include?("linkedin")
  #       student[:linkedin] = link
  #     elsif link.include?("github")
  #       student[:github] = link
  #     elsif link.include?("twitter")
  #       student[:twitter] = link
  #     else
  #       student[:blog] = link
  #     end
  #   end
  #   # student[:twitter] = profile_page.css(".social-icon-container").children.css("a")[0].attribute("href").value
  #   # # if profile_page.css(".social-icon-container").children.css("a")[0]
  #   # student[:linkedin] = profile_page.css(".social-icon-container").children.css("a")[1].attribute("href").value if profile_page.css(".social-icon-container").children.css("a")[1]
  #   # student[:github] = profile_page.css(".social-icon-container").children.css("a")[2].attribute("href").value if profile_page.css(".social-icon-container").children.css("a")[2]
  #   # student[:blog] = profile_page.css(".social-icon-container").children.css("a")[3].attribute("href").value if profile_page.css(".social-icon-container").children.css("a")[3]
  #   student[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")
  #   student[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text if profile_page.css("div.bio-content.content-holder div.description-holder p")
  #
  #   student
  # end

end

# Scraper.scrape_profile_page("./fixtures/student-site/students/aaron-enser.html")

require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read('./fixtures/student-site/index.html')
    studentsite = Nokogiri::HTML(html)

    students = []
    counter = 0

    studentsite.css("div.student-card").each do |student|
      students[counter] = {
        :name => student.css(".card-text-container h4.student-name").text,
        :location => student.css(".card-text-container p.student-location").text,
        :profile_url => student.css("a")[0]["href"]
      }
      counter += 1
    end

    students
  end

  def self.scrape_profile_page(profile_url)
    url = "#{profile_url}"
    html = File.read(url)
    studentpage = Nokogiri::HTML(html)

    student = {}

    vitals = studentpage.css("div.vitals-container")
    details = studentpage.css("div.details-container")

    student = {
      :profile_quote => vitals.css(".vitals-text-container div.profile-quote").text,
      :bio => details.css(".details-container .description-holder p").text
    }

    vitals.css(".social-icon-container a").each do |link|
      if link.attribute("href").value =~ /twitter/i
        name = "twitter"
      elsif link.attribute("href").value =~ /github/i
        name = "github"
      elsif link.attribute("href").value =~ /linkedin/i
        name = "linkedin"
      else
        name = "blog"
      end
      student[name.to_sym] = link.attribute("href").value
    end

    student
  end

end

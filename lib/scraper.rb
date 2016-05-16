require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.open_doc(url)
    @parse_page = Nokogiri::HTML(open(url))
    @parse_page
  end

  def self.scrape_index_page(index_url)
    scraped_students = []

    self.open_doc(index_url).css(".student-card").each do |student|
      scraped_students << {
        :name=>student.css("a").css(".card-text-container").css("h4").text,
        :location=>student.css("a").css(".card-text-container").css("p").text,
        :profile_url=>index_url+student.css("a").attribute("href").value
        }
    end

    #binding.pry
    scraped_students

  end

  def self.scrape_profile_page(profile_url)
    scraped_student = {}

    self.open_doc(profile_url).css(".vitals-container").css(".social-icon-container").css("a").each do |ref|
      if URI.parse(ref.attribute("href").value).path !="/"
      scraped_student[URI.parse(ref.attribute("href").value).host.gsub(/\Aw+./,'').gsub(/\W.\w+/,'').to_sym]=ref.attribute("href").value
      else
        scraped_student[:blog] = ref.attribute("href").value
      end
    end

    scraped_student[:profile_quote] = self.open_doc(profile_url).css(".vitals-container").css(".profile-quote").text
    scraped_student[:bio] = self.open_doc(profile_url).css(".details-container").css("p").text

  scraped_student
  end

end
#tmp=Scraper.scrape_index_page("http://0.0.0.0:3000/")
#Scraper.scrape_profile_page(tmp[0][:profile_url])

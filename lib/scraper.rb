require 'open-uri'
require 'Nokogiri'
require 'pry'

class Scraper
  attr_accessor :url_of_index

  def self.scrape_index_page(index_url)
    @url_of_index = self.base_url(index_url)
    page = self.sashimi(index_url)
    students = page.css(".student-card")
    students.collect do |student|
      self.hashify_student(student)
    end
  end

  def self.hashify_student(student)
    {}.tap do |hash|
      hash[:location] = student.css(".student-location").text
      hash[:name] = student.css(".student-name").text
      hash[:profile_url] = @url_of_index + student.css("a").attr("href").value
      # student.css("a")[0].attributes["href"].value
      # student.xpath("a/@href")[0].value
    end
  end

  def self.base_url(url)
    url.match(/(.*\/).*/).captures[0]
  end

  def self.scrape_profile_page(profile_url)
    page = self.sashimi(profile_url)
    {}.tap do |hash|
      hash.merge!(self.get_social(page))
      hash[:profile_quote] = page.css(".vitals-text-container .profile-quote").text
      hash[:bio] = page.css(".bio-content .description-holder p").text
    end
  end

  def self.get_social(page)
    page = page.css(".vitals-container .social-icon-container a")
    social_array = page.collect{|element| element.attr("href")}
    {}.tap do |hash|
      social_array.each do |url|
        if url.match(/http:\/\//)
          hash["blog".to_sym] = url
        elsif url.match(/https:\/\//)
          name = url.match(/s:\/\/(.*\.|)(.*)\./).captures[1]
          hash[name.to_sym] = url
        end
      end
    end
  end

  def self.sashimi(url)
    Nokogiri::HTML(open(url))
  end
end

#index_url = "./fixtures/student-site/index.html"
#scraped_students = Scraper.scrape_index_page(index_url)
#binding.pry

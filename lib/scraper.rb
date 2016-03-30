require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_site = Nokogiri::HTML(open(index_url))

    student_site.css(".student-card").map do |student|
      {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => "#{index_url}#{student.css('a').attribute('href').text}"
      }
    end
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    
    social_media_links = profile_page.
      xpath('//div[contains(@class, "social-icon")]/a').
      map do |el|
        el.attributes['href'].value
      end

    student_hash = {}

    social_media_links.each do |link|
      if /twitter/.match(link)
        student_hash[:twitter] = link
      elsif /linkedin/.match(link)
        student_hash[:linkedin] = link
      elsif /github/.match(link)
        student_hash[:github] = link
      else
        student_hash[:blog] = link
      end
    end

    student_hash[:profile_quote] = profile_page.xpath('//div[contains(@class, "profile-quote")]').text if profile_page.xpath('//div[contains(@class, "profile-quote")]')
    student_hash[:bio] = profile_page.xpath('//div[contains(@class, "bio-content")]/div[contains(@class, "description-holder")]').text.gsub(/\n\s+/,'') if profile_page.xpath('//div[contains(@class, "bio-content")]/div[contains(@class, "description-holder")]')

    student_hash
  end

end

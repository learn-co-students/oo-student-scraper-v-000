require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    students = []

    children = doc.css('.student-card')

    children.each do |student|
      students << {
        :name => student.css('.student-name').text,
        :location => student.css('.student-location').text,
        :profile_url => student.css('a')[0]['href']
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    @details = {:profile_quote => doc.css('div.profile-quote').text, :bio => doc.css('div.description-holder p').text}

    doc.css('div.social-icon-container a').each_with_index {|media, index|
      if media.to_s.include? 'twitter'
        @details[:twitter] = doc.css('div.social-icon-container a')[index]['href']
      end
      if media.to_s.include? 'linkedin'
        @details[:linkedin] = doc.css('div.social-icon-container a')[index]['href']
      end
      if media.to_s.include? 'github'
        @details[:github] = doc.css('div.social-icon-container a')[index]['href']
      end
      if media.to_s.include? 'rss'
        @details[:blog] = doc.css('div.social-icon-container a')[index]['href']
      end
      }

    @details
  end

end

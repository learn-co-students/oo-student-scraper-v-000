require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
     doc = Nokogiri::HTML(open(index_url))
     student_array = []
     doc.search('.student-card').each do |student|
       student_hash = {
       :name => student.search('.student-name').text,
       :location => student.css('p.student-location').text,
       :profile_url => student.css('a').attr('href').value
       }
       student_array << student_hash
     end
     student_array

  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile_hash = {}
      if social_zero = doc.css('.social-icon-container').search('a')[0]
        if social_zero .attr('href').include?("twitter")
         profile_hash[:twitter] = social_zero.attr('href')
        elsif social_zero .attr('href').include?("linkedin")
         profile_hash[:linkedin] = social_zero.attr('href')
        elsif social_zero .attr('href').include?("github")
         profile_hash[:github] = social_zero.attr('href')
        else profile_hash[:blog] = social_zero.attr('href')
        end
      end
      if social_one = doc.css('.social-icon-container').search('a')[1]
        if social_one.attr('href').include?("linkedin")
         profile_hash[:linkedin] = social_one.attr('href')
        elsif social_one.attr('href').include?("github")
         profile_hash[:github] = social_one.attr('href')
        else profile_hash[:blog] = social_one.attr('href')
        end
      end
      if social_two = doc.css('.social-icon-container').search('a')[2]
        if social_two.attr('href').include?("github")
         profile_hash[:github] = social_two.attr('href')
        else profile_hash[:blog] = social_two.attr('href')
        end
      end
      if blog = doc.css('.social-icon-container').search('a')[3]
      profile_hash[:blog] = blog.attr('href')
      end
      profile_hash[:profile_quote] = doc.css('div.profile-quote').text
      profile_hash[:bio] = doc.css('.description-holder').search('p').text
    profile_hash
    # profile_hash = {
    #   :twitter => doc.css('.social-icon-container').search('a')[0].attr('href'),
    #   :linkedin => doc.css('.social-icon-container').search('a')[1].attr('href'),
    #   :github => doc.css('.social-icon-container').search('a')[2].attr('href'),
    #   :blog=> doc.css('.social-icon-container').search('a')[3].attr('href'),
    #   :profile_quote => doc.css('div.profile-quote').text,
    #   :bio => doc.css('.description-holder').search('p').text
    #  }
  end

end

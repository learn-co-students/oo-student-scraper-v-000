require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []

    index_page.css('div.roster-cards-container').each do |card|
      card.css('.student-card a').each do |student|
        student_name = student.css('h4.student-name').text
        student_location = student.css('p.student-location').text
        student_profile_link = student.attr('href')
        students << {name: student_name, location: student_location, profile_url: student_profile_link}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    students = {}
    social = profile_page.css('div.social-icon-container').children.css('a').map{ |icon| icon.attribute('href').value}
    social.each do |link|

      if link.include?('twitter')
        students[:twitter] = link

      elsif link.include?('linkedin')
        students[:linkedin] = link

      elsif link.include?('github')
        students[:github] = link

      else
        students[:blog] = link
      end
    end

    profile_page.css('.vitals-text-container').each do |quote|
      students[:profile_quote] = quote.css('.profile-quote').text
    end

    profile_page.css('.bio-content').each do |bio|
      students[:bio] = bio.css('.description-holder p').text
    end
    # binding.pry
    students.reject{|k,v| v.nil?}
  end

end

# social = profile_page.css('div.social-icon-container')
# icon = social.css('.social-icon-container')

# links[:twitter] = if icon.css('a').attribute('href').value.include?('twitter.com')
#   icon.css('a').attribute('href').value
# end
#
# links[:github] = if icon.css('a').attribute('href').value.include?('github.com')
#   icon.css('a').attribute('href').value
# end

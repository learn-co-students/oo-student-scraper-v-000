require 'open-uri'
require 'pry'

class Scraper
#name location profile url
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url)) #this fetches the parameter passed & tells it to parse


# puts doc.css(".student-card").text.inspect  <-- example to debug
# binding.pry other way to debug

    doc.css(".student-card").collect do |detail|
      {
        name: detail.css('.student-name').text,
        location: detail.css('.student-location').text,
        profile_url: './fixtures/student-site/' + detail.css('a').attribute('href').value

      }
    end
  end


#twitter url, linkedin url, github url, blog url, profile quote, and bio.
  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
# binding.pry
    profile_quote = doc.css('.profile-quote').text
    bio= doc.css(".description-holder p").text

  result = {  # <--- hash that will be put out
      profile_quote: profile_quote,
      bio: bio
    }

    links = doc.css(".social-icon-container a").collect{ |link| link.attribute('href').value }

    twitter =  links.detect { |link| link.include?('twitter.com') }
    linkedin =  links.detect { |link| link.include?('linkedin.com') }
    github =  links.detect { |link| link.include?('github.com') }

    remaining_links = links - [twitter, linkedin, github]
    blog = remaining_links.first
    if remaining_links.length > 1
      raise "Unexpected extra link on #{profile_url}" #line of code that will run if there is an 'error'
    end

    if twitter
      result[:twitter] = twitter #<--- determines if the key goes into the hash
    end

    if linkedin
      result[:linkedin] = linkedin
    end

    if github
      result[:github] = github
    end

    if blog
      result[:blog] = blog
    end
    result

  end

end

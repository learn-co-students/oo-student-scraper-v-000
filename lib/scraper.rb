require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    profiles = Nokogiri::HTML(open("http://students.learn.co/"))

    profiles_array = []
    profiles_hash = {}

    profiles.css("div.roster-cards-container").each do |profile|
      profile.css("div.student-card").each do |i|
        binding.pry
      info = profile.css("div.student-card").text
      profiles_hash[info.to_sym] = {
      :name => i.css("a div.card-text-container h4.student-name").text,
      :location => i.css("a div.card-text-container p.student-location").text,
      :profile_url => i.css("a").attribute("href").text
    }
    profiles_array << profiles_hash
   end
 end
  profiles_array
end

  def self.scrape_profile_page(profile_url)
    #     doc = Nokogiri::HTML.parse(<<-HTML_END)
    # <div class="heat">
    #    <a href='http://example.org/site/1/'>site 1</a>
    #    <a href='http://example.org/site/2/'>site 2</a>
    #    <a href='http://example.org/site/3/'>site 3</a>
    # </div>
    # <div class="wave">
    #    <a href='http://example.org/site/4/'>site 4</a>
    #    <a href='http://example.org/site/5/'>site 5</a>
    #    <a href='http://example.org/site/6/'>site 6</a>
    # </div>
    # HTML_END
    #
    # l = doc.css('div.heat a').map { |link| link['href'] }

  end

end

# Scraper.new

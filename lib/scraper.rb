require 'open-uri'
require 'pry'

class Scraper
  #WebMock.disable_net_connect!(:allow_localhost => true)
  def self.scrape_index_page(index_url)
    @index_url = index_url
    @doc = Nokogiri::HTML(open(index_url))
    @rows = @doc.search('div.student-card')
    @data = Array.new
    @rows.each do |student|
      @data << self.scrape_index_rows(student)
    end
    @data
  end

  def self.scrape_profile_page(profile_url)
    @doc = Nokogiri::HTML(open(profile_url))
    @social = @doc.search('div.social-icon-container')
    @student = Hash.new
    self.scrape_social_rows(@social)
    @student[:profile_quote]= @doc.search('div.profile-quote').text
    @student[:bio] = @doc.search('div.description-holder p').text

    @student
  end
private
  def self.scrape_index_rows(row)
    {
      :profile_url => "#{@index_url}#{row.search('a').attribute('href').value}",
      :name => row.search('h4.student-name').text,
      :location => row.search('p.student-location').text
    }
  end
  def self.scrape_social_rows(social)
    social.search("a").each do |social_link|
      link = social_link.attribute('href').value
      case
        when link.match(/twitter/) #twitter
          @student[:twitter] = link
        when link.match(/linkedin/)#linkedin
          @student[:linkedin] = link
        when link.match(/github/)#github
          @student[:github]=  link
        else #blog
          @student[:blog] = link
      end
    end
  end

end

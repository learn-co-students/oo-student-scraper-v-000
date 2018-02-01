require 'open-uri'
require 'pry'


class Scraper

  def self.scrape_index_page(index_url)
     html = File.read(index_url)
     noko = Nokogiri::HTML(html)
     x = noko.search(".student-card")
    #  binding.pry
    #  [<div class="card">
    #   [<h2 id="logo">Title</h2>]
    #   [<p class="content">Something here</p>]
    #  <div>]
      array = []
     x.each do |person|
       array << { name: person.css('h4.student-name').text, location: person.search('p.student-location').text, profile_url: person.css('a').first["href"]}
     end
     array
  end



  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    noko = Nokogiri::HTML(html)
    # binding.pry

    x = noko.css("div.social-icon-container a")

    @rhash = {}


      # binding.pry
      # x = noko.css("div.profile-quote").text
      #  noko.css('a').first["href"]
      # @rhash[:quote] = x
      x.each do |student|
        # binding.pry
        link = student.attributes["href"].value
        if link.include?("twitter")
          @rhash[:twitter] = link
        elsif link.include?("github")
          @rhash[:github] = link
        elsif link.include?("linkedin")
          @rhash[:linkedin] = link
        else
          @rhash[:blog] = link
        end

        # binding.pry

        if noko.css("div.profile-quote")
          @rhash[:profile_quote] = noko.css("div.profile-quote").text
        end

        if noko.css("div.description-holder p")
          @rhash[:bio] = noko.css("div.description-holder p").text
        end

        # binding.pry
      end

      # pushing stuff into the hash- interpreting the stuff in x, checking if its
      # a twtter link for example

      # you can use .include? to check which one it is. if it's none of them, it's
      # a blog. and add them into @rhash


      # @rhash

    # binding.pry
    @rhash

  end
  # binding.pry
end

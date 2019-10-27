require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open('./fixtures/student-site/index.html'))
    students = doc.css('div.student-card')
    students_parsed = []
    students.each do |s|
      students_parsed << {
        name: s.css('.student-name').text,
        location: s.css('.student-location').text,
        profile_url: "#{s.at('a').first[1]}"
      }
    end
    students_parsed
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open("#{profile_url}"))
    social = {
      profile_quote: doc.css('.profile-quote').text.strip.gsub(/\s+/, " "),
      bio: doc.css('.bio-content .description-holder p').text.strip.gsub(/\s+/, " "),
    }

    if (match = %r{([^"]*)twitter.com/([^"]*)}.match(doc.css('a').to_s))
      social[:twitter] = match[0]
    end

    if (match = %r{([^"]*)linkedin.com/([^"]*)}.match(doc.css('a').to_s))
      social[:linkedin] = match[0]
    end

    if (match = %r{([^"]*)youtube.com/([^"]*)}.match(doc.css('a').to_s))
      social[:youtube] = match[0]
    end

    if (match = %r{([^"]*)github.com/([^"]*)}.match(doc.css('a').to_s))
      social[:github] = match[0]
    end

    if (match = %r{([^"]*)([^"]*)[^youtube][^linkedin].com/([^"]*)}.match(doc.css('.social-icon-container a').to_s))
      social[:blog] = match[0]
    end

    social

  end

end

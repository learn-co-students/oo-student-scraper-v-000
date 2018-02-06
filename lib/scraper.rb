class Scraper
  
  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    students_index = page.css('div.roster-body-wrapper div.roster-cards-container div.student-card')
    
    # initialize return array
    students = []
    
    # scrape desired attributes for each student
    students_index.each_with_index do |student, i|
      students[i] = {
        name:        student.css('a div.card-text-container h4.student-name').text,
        location:    student.css('a div.card-text-container p.student-location').text,
        profile_url: student.css('a')[0]['href']
      }
    end
    
    # return array
    students
  end
  
  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    vitals  = page.css('div.profile div.vitals-container')
    details = page.css('div.profile div.details-container')
    
    # initialize return hash
    student = {
      github: nil, linkedin: nil, twitter: nil, blog: nil,
      profile_quote: nil, bio: nil
    }
    
    # scrape social media attributes
    vitals.css('div.social-icon-container > a').each do |a|
      url = a['href']
      if    url.include?('github'  ) then student[:github  ] = url
      elsif url.include?('linkedin') then student[:linkedin] = url
      elsif url.include?('twitter' ) then student[:twitter ] = url
      elsif url.include?('facebook') then #student[:facebook] = url
      elsif url.include?('youtube' ) then #student[:youtube ] = url
      else  student[:blog] = url
      end
    end
    
    # scrape profile quote and bio
    student[:profile_quote] = vitals.css('div.vitals-text-container div.profile-quote').text
    student[:bio          ] = details.css('div.bio-block div.bio-content div.description-holder > p').text
    
    # return hash
    student.reject{|k,v| v==nil}
  end
  
end
def self.scrape_profile_page(profile_url)
    html = File.read(open(profile_url))
    profile_page = Nokogiri::HTML(html)

    all_profiles = {}

    profile_page.css("div.social-icon-container a").each do |profile|
      twitter = profile_page.css("div.social-icon-container a").attr("href").value
      linkedin = profile_page.css("div.social-icon-container a")[1].attr("href")
      github = profile_page.css("div.social-icon-container a")[2].attr("href")
      blog = profile_page.css("div.social-icon-container a")[3].attr("href")
      profile_quote = profile_page.css(".profile-quote").text
      bio = profile_page.css(".details-container p").children.text

      all_profiles = {:twitter => twitter, :linkedin => linkedin, :github => github, :blog => blog, :profile_quote => profile_quote, :bio => bio}

    end
      all_profiles
  end

  -------------------------------------------

  def self.scrape_profile_page(profile_url)
    html = File.read(open(profile_url))
    profile_page = Nokogiri::HTML(html)
    all_profiles = {}

    profile_page.css("div.social-icon-container a").each do |profile|
      # twitter = profile_page.css("div.social-icon-container a").attribute("href").value
      # linkedin = profile_page.css("div.social-icon-container a")[1].attribute("href").value
      # github = profile_page.css("div.social-icon-container a")[2].attribute("href").value
      blog = profile_page.css("div.social-icon-container a")[3].attribute("href").value
      profile_quote = profile_page.css(".profile-quote").text
      bio = profile_page.css(".details-container p").children.text

        if profile["href"].include?("twitter")
          twitter = profile_page.css("div.social-icon-container a").attribute("href").value
          all_profiles[:twitter] = twitter
        elsif profile["href"].include?("linkedin")
          linkedin = profile_page.css("div.social-icon-container a")[1].attribute("href").value
          all_profiles[:linkedin] = twitter
        elsif profile["href"].include?("github")
          github = profile_page.css("div.social-icon-container a")[2].attribute("href").value
          all_profiles[:github] = twitter
        end

        all_profiles = {:twitter => twitter, :linkedin => linkedin, :github => github, :blog => blog, :profile_quote => profile_quote, :bio => bio}

      # all_profiles[:profile_quote] = profile_quote
      # all_profiles[:bio] = bio
    end #each line 32

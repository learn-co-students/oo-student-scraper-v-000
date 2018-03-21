
[1mFrom:[0m /home/MarsRoamer/oo-student-scraper-v-000/lib/scraper.rb @ line 41 Scraper.scrape_profile_page:

    [1;34m26[0m:   [32mdef[0m [1;36mself[0m.[1;34mscrape_profile_page[0m(profile_url)
    [1;34m27[0m:     hash = {}
    [1;34m28[0m:     html = open(profile_url)
    [1;34m29[0m:     doc = [1;34;4mNokogiri[0m::HTML(html)
    [1;34m30[0m:     iteration = doc.css([31m[1;31m'[0m[31m.social-icon-container[1;31m'[0m[31m[0m)
    [1;34m31[0m:     socialLinks = doc.css([31m[1;31m'[0m[31m.social-icon-container a[1;31m'[0m[31m[0m)
    [1;34m32[0m: 
    [1;34m33[0m:     socialLinks.each [32mdo[0m |link|
    [1;34m34[0m:       holder = link[[31m[1;31m'[0m[31mhref[1;31m'[0m[31m[0m].to_str
    [1;34m35[0m:       assign = holder.scan([35m[1;35m/[0m[35m(?<=www.).+(?=.com)[1;35m/[0m[35m[0m).join
    [1;34m36[0m:       twitter = holder.scan([35m[1;35m/[0m[35m(?<=[1;35m\/[0m[35m[1;35m\/[0m[35m).+(?=.com)[1;35m/[0m[35m[0m).join
    [1;34m37[0m:       [32mif[0m assign == [31m[1;31m'[0m[31mtwitter.com[1;31m'[0m[31m[0m || twitter == [31m[1;31m'[0m[31mtwitter.com[1;31m'[0m[31m[0m
    [1;34m38[0m:         test = twitter
    [1;34m39[0m:       [32mend[0m
    [1;34m40[0m: 
 => [1;34m41[0m: binding.pry
    [1;34m42[0m: [32mend[0m
    [1;34m43[0m:     [1;34m# iteration.each do |element|[0m
    [1;34m44[0m:     [1;34m#   hash[:twitter] = element.css('a')[0]['href'][0m
    [1;34m45[0m:     [1;34m#   hash[:linkedin] = element.css('a')[1]['href'][0m
    [1;34m46[0m:     [1;34m#   hash[:github] = element.css('a')[2]['href'][0m
    [1;34m47[0m:     [1;34m#   hash[:blog] = element.css('a')[3]['href'][0m
    [1;34m48[0m:     [1;34m#   hash[:profile_quote] = doc.css('.profile-quote').text[0m
    [1;34m49[0m:     [1;34m#   hash[:bio] = doc.css('.description-holder p').text[0m
    [1;34m50[0m:     [1;34m# end[0m
    [1;34m51[0m:     [1;34m# hash[0m
    [1;34m52[0m:   [32mend[0m


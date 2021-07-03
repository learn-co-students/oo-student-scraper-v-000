
[1mFrom:[0m /home/JLPinthecity/oo-student-scraper-v-000/lib/scraper.rb @ line 25 Scraper.scrape_profile_page:

    [1;34m22[0m:   [32mdef[0m [1;36mself[0m.[1;34mscrape_profile_page[0m(profile_url) [1;34m#responsible for scraping an individual's student's profile page to get further info about student[0m
    [1;34m23[0m:     doc = [1;34;4mNokogiri[0m::HTML(open(profile_url))
    [1;34m24[0m:     student = {}
 => [1;34m25[0m:     binding.pry
    [1;34m26[0m:     social_networks = doc.css([31m[1;31m"[0m[31mdiv.social-icon-container a[1;31m"[0m[31m[0m).collect [32mdo[0m |social|
    [1;34m27[0m:       social.attribute([31m[1;31m"[0m[31mhref[1;31m"[0m[31m[0m).value
    [1;34m28[0m:       [32mend[0m
    [1;34m29[0m:       binding.pry
    [1;34m30[0m:       social_networks.each [32mdo[0m |social|
    [1;34m31[0m:         [32mif[0m social.include?([31m[1;31m"[0m[31mlinkedin[1;31m"[0m[31m[0m)
    [1;34m32[0m:         student[[33m:linkedin[0m] = social
    [1;34m33[0m:       [32melsif[0m social.include?([31m[1;31m"[0m[31mgithub[1;31m"[0m[31m[0m)
    [1;34m34[0m:         student[[33m:github[0m] = social
    [1;34m35[0m:       [32melsif[0m social.include?([31m[1;31m"[0m[31mtwitter[1;31m"[0m[31m[0m)
    [1;34m36[0m:         student[[33m:twitter[0m] = social
    [1;34m37[0m:       [32melse[0m
    [1;34m38[0m:         student[[33m:blog[0m] = social
    [1;34m39[0m:       [32mend[0m
    [1;34m40[0m:     [32mend[0m
    [1;34m41[0m:           [1;34m#:profile_quote[0m
    [1;34m42[0m:           [1;34m#:bio[0m
    [1;34m43[0m: 
    [1;34m44[0m: [32mend[0m


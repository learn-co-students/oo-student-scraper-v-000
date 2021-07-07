
[1mFrom:[0m /home/kmoosman/oo-student-scraper-v-000/lib/scraper.rb @ line 33 Scraper.scrape_profile_page:

    [1;34m25[0m: [32mdef[0m [1;36mself[0m.[1;34mscrape_profile_page[0m(profile_url)
    [1;34m26[0m:   profile_html = open(profile_url)
    [1;34m27[0m:   profile_site = [1;34;4mNokogiri[0m::HTML(profile_html)
    [1;34m28[0m:   details = {}
    [1;34m29[0m: 
    [1;34m30[0m:   profile_site.css([31m[1;31m"[0m[31mdiv.social-icon-container a[1;31m"[0m[31m[0m).each [32mdo[0m |social_link|
    [1;34m31[0m:     [1;34m#linkedin, github, blog, twitter profileQuite, bio[0m
    [1;34m32[0m:     link = social_link.attribute([31m[1;31m"[0m[31mhref[1;31m"[0m[31m[0m).value
 => [1;34m33[0m:     [32mcase[0m
    [1;34m34[0m:     [32mwhen[0m social_link.include?([31m[1;31m"[0m[31mtwitter[1;31m"[0m[31m[0m)
    [1;34m35[0m:         details[[33m:twitter[0m] = link
    [1;34m36[0m:     [32mwhen[0m social_link.include?([31m[1;31m"[0m[31mlinkedin[1;31m"[0m[31m[0m)
    [1;34m37[0m:         details[[33m:linkedin[0m] = link
    [1;34m38[0m:     [32mwhen[0m social_link.include?([31m[1;31m"[0m[31mgithub[1;31m"[0m[31m[0m)
    [1;34m39[0m:         details[[33m:github[0m] = link
    [1;34m40[0m:     [32mwhen[0m social_link.include?([31m[1;31m"[0m[31m.com[1;31m"[0m[31m[0m)
    [1;34m41[0m:         details[[33m:blog[0m] = link
    [1;34m42[0m:     [32mend[0m
    [1;34m43[0m:   [32mend[0m
    [1;34m44[0m:   details[[33m:profile_quote[0m] = profile_site.css([31m[1;31m"[0m[31m.profile-quote[1;31m"[0m[31m[0m).text
    [1;34m45[0m:   details[[33m:bio[0m] = profile_site.css([31m[1;31m"[0m[31mdiv.description-holder p[1;31m"[0m[31m[0m).text
    [1;34m46[0m:   details
    [1;34m47[0m: 
    [1;34m48[0m: 
    [1;34m49[0m: 
    [1;34m50[0m: [32mend[0m


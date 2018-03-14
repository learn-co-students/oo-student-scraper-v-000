
[1mFrom:[0m /home/crittenbach-42490/code/labs/oo-student-scraper-v-000/lib/scraper.rb @ line 46 Scraper.scrape_profile_page:

    [1;34m25[0m: [32mdef[0m [1;36mself[0m.[1;34mscrape_profile_page[0m(profile_url)
    [1;34m26[0m: 
    [1;34m27[0m:   html = [1;34;4mFile[0m.read(profile_url.to_s)
    [1;34m28[0m:   index = [1;34;4mNokogiri[0m::HTML(html)
    [1;34m29[0m: 
    [1;34m30[0m:   cards = {}
    [1;34m31[0m:   social = []
    [1;34m32[0m: 
    [1;34m33[0m: 
    [1;34m34[0m:    index.css([31m[1;31m"[0m[31m.social-icon-container[1;31m"[0m[31m[0m).each [32mdo[0m |container|
    [1;34m35[0m:       social << container.css([31m[1;31m"[0m[31ma[1;31m"[0m[31m[0m).attribute([31m[1;31m"[0m[31mhref[1;31m"[0m[31m[0m).value
    [1;34m36[0m:     [32mend[0m
    [1;34m37[0m: 
    [1;34m38[0m: 
    [1;34m39[0m: 
    [1;34m40[0m:   index.css([31m[1;31m"[0m[31m.vitals-text-container[1;31m"[0m[31m[0m).collect [32mdo[0m |card|
    [1;34m41[0m:       cards[[33m:profile_quote[0m] = card.css([31m[1;31m"[0m[31m.profile-quote[1;31m"[0m[31m[0m).text.strip
    [1;34m42[0m:   [32mend[0m
    [1;34m43[0m: 
    [1;34m44[0m:     cards[[33m:bio[0m] = index.css([31m[1;31m"[0m[31m.description-holder p[1;31m"[0m[31m[0m).text.strip
    [1;34m45[0m: 
 => [1;34m46[0m:  binding.pry
    [1;34m47[0m:  cards
    [1;34m48[0m: 
    [1;34m49[0m: [32mend[0m


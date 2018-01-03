
[1mFrom:[0m /home/alexcrisan/code/labs/oo-student-scraper-v-000/lib/scraper.rb @ line 41 Scraper.scrape_profile_page:

    [1;34m22[0m: [32mdef[0m [1;36mself[0m.[1;34mscrape_profile_page[0m(profile_url)
    [1;34m23[0m:   doc = [1;34;4mNokogiri[0m::HTML(open(profile_url))
    [1;34m24[0m:   [1;34m#is a class method that scrapes a student's profile page and returns a hash of attributes describing an individual student (FAILED - 1) can handle profile pages without all of the social links[0m
    [1;34m25[0m:   scraped_profile = {}
    [1;34m26[0m:   attributes = doc.css([31m[1;31m"[0m[31m.social-icon-container[1;31m"[0m[31m[0m)
    [1;34m27[0m:   [1;34m# scooby = attributes.css("a")[1]["href"][0m
    [1;34m28[0m: 
    [1;34m29[0m:   attributes.css([31m[1;31m"[0m[31ma[1;31m"[0m[31m[0m).each [32mdo[0m |attribute|
    [1;34m30[0m:     attribute_url = attribute[[31m[1;31m"[0m[31mhref[1;31m"[0m[31m[0m] [1;34m#www.twitter.com...[0m
    [1;34m31[0m:     attribute_name = attribute_url.gsub([35m[1;35m/[0m[35mhttp(s)?:[1;35m\/[0m[35m[1;35m\/[0m[35m(www.)?|.(com|net|co.uk|us)+.*[1;35m/[0m[35m[0m, [31m[1;31m'[0m[31m[1;31m'[0m[31m[0m) [1;34m#twitter[0m
    [1;34m32[0m:     [32mif[0m attribute_name == [31m[1;31m"[0m[31mtwitter[1;31m"[0m[31m[0m || attribute_name == [31m[1;31m"[0m[31mlinkedin[1;31m"[0m[31m[0m || attribute_name == [31m[1;31m"[0m[31mgithub[1;31m"[0m[31m[0m
    [1;34m33[0m:       attribute_symbol = attribute_name.to_sym
    [1;34m34[0m:       scraped_profile[attribute_symbol] = attribute_url
    [1;34m35[0m:     [32melse[0m
    [1;34m36[0m:       scraped_profile[[33m:blog[0m] = attribute_url
    [1;34m37[0m:     [32mend[0m
    [1;34m38[0m:   [32mend[0m
    [1;34m39[0m:   [1;34m#find if student has a quote, then add it to the hash.[0m
    [1;34m40[0m:   scraped_profile
 => [1;34m41[0m:   binding.pry
    [1;34m42[0m: [32mend[0m


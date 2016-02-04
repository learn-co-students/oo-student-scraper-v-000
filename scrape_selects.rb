students = css("div.student-card")
name = students.first.css("h4.student-name").text
location = students.first.css("p.student-location").text
profile_url = students.first.css("a").first["href"]

#potential loop

students.each do |students|
  name = student.css("h4.student-name").text
  location = student.css("p.student-location").text
  profile_url = student.css("a").first["href"]
end

# for profile page scraping
profile_page = css("")

# Need to pullin array of all social links, then detect ones where the href includes the social network name.
# What to do about the blog?
## Maybe for blog, choose the href that does not include any of the social media names
#Example of blogger profile: http://127.0.0.1:4000/students/danny-dawson.html
social = css("div.social-icon-container a")
twitter = social[0]["href"]
linkedin = social[1]["href"]
github = social[2]["href"]
git = social.detect {|x| x["href"].include? "github"}



blog =
profile_quote = css("div.profile-quote").text
bio = css.("div.descripton-holder p").text
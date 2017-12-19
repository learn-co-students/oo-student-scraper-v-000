class Student
  attr_accessor :name, :location, :profile_url, :bio, :twitter, :linkedin, :github, :blog, :profile_quote

  def intialize
  end

  def index_hash
    {
      name: self.name,
      location: self.location,
      profile_url: self.profile_url,
    }
  end

  def profile_hash
    {
      bio: self.bio,
      twitter: self.twitter,
      linkedin: self.linkedin,
      github: self.github,
      blog: self.blog,
      profile_quote: self.profile_quote
    }
  end

end
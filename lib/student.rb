class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    add_student_attributes(student_hash)
    @@all << self
  end

  def self.create_from_collection(students_array)
    
  end

  def add_student_attributes(student_hash)
    @name=student_hash[:name] if student_hash.has_key?(:name)
    @location=student_hash[:location] if student_hash.has_key?(:location)
    @twitter=student_hash[:twitter] if student_hash.has_key?(:twitter)
    @linkedin=student_hash[:linkedin] if student_hash.has_key?(:linkedin)
    @github=student_hash[:github] if student_hash.has_key?(:github)
    @blog=student_hash[:blog] if student_hash.has_key?(:blog)
    @profile_quote=student_hash[:profile_quote] if student_hash.has_key?(:profile_quote)
    @bio=student_hash[:bio] if student_hash.has_key?(:bio)
    @profile_url=student_hash[:profile_url] if student_hash.has_key?(:profile_url)
  end

  def self.all
    
  end
end


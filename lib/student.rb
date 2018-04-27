class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    self.class.all << self
    set_from_hash(student_hash)
  end

  def self.create_from_collection(students_array)
    students_array.each { |e| self.new(e)}
  end

  def add_student_attributes(attributes_hash)
    set_from_hash(attributes_hash)
    self
  end

  def self.all
    @@all
  end

private
  def set_from_hash(stud_hash, stud = self)
    stud_hash.each_pair do |k, v|
      stud.send(("#{k.to_s}="), v)
    end
  end
end

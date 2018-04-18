class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(attributes_hash)
    attributes_hash.each { |key, value| send("#{key}=", value) }
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |student|
      self.new({:name=>student[:name], :location=>student[:location]})
    end

  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each { |key, value| send("#{key}=",value)}
  end

  def self.all
    @@all
  end
end

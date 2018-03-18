# require_relative './scraper.rb'

class Student


  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url, :students

  @@all = []

    def initialize(student_hash)
      student_hash.each {|key, value| self.send(("#{key}="), value)}
      @@all << self
  end

  def self.create_from_collection(student_hash)


        student_hash.collect do |student|

        s = Student.new(student)

        s.name=(student[:name])
        s.location=(student[:location])
        end
    end

  def add_student_attributes(attributes_hash)
    attributes_hash.each {|key, value| self.send(("#{key}="), value)}
   self
  end

  def self.all
    @@all
  end
end

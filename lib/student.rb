class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student_hash.each do |attributes, value|

      # the key and value come back with correct info- not sure I how to use .send
      # also have tried self.send[attribute] = value per blog
      #self.send(attribute, [value]),self.send(attribute, value)
      # https://jaketrent.com/post/ruby-call-dynamic-method/
    self.send("#{attributes}=", value)
    end

    @@all << self
  end

  def self.create_from_collection(students_array)

    students_array.each do |student_hash|
      Student.new(student_hash)
    end
  end

  def add_student_attributes(attributes_hash)
       attributes_hash.each do |attributes , value|
         self.send("#{attributes}=", value)
       end

  end

  def self.all
    @all.to_a
  end
end

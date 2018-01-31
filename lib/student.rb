require 'pry'

class Student
  attr_accessor :id, :name, :grade

  def self.new_from_db(row)
    # binding.pry
    Student.new.tap do |student|
      binding.pry
      student.name = row[1]
      student.grade = row[2]
      student.id = row[0]
    end
    # create a new Student object given a row from the database
  end

  def self.all
    # retrieve all the rows from the "Students" database
    # remember each row should be a new instance of the Student class
    sql = <<-SQL
      SELECT * FROM Students
    SQL

    DB[:conn].execute(sql).map do |el|
      self.new_from_db(el)
    #   binding.pry
    #   self.id = el
    end
  end

  def self.find_by_name(name)
    sql = <<-SQL
      SELECT * FROM students
      WHERE name = ?
    SQL

    DB[:conn].execute(sql, name)
    binding.pry
    self.new_from_db(x)
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
  end

  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade INTEGER
    )
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end
end

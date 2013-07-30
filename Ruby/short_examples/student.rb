# Aaron Krauss - Question 1
# Estimated time: 42 min including analysis of bad code
# Source used:
# http://stackoverflow.com/questions/5114584/how-to-use-ruby-case-when-with-inequalities
# Command to run: ruby ques_1_rewrite.rb
#   => However, you'll need to comment out line 19 since there's no Students model

class Student

  attr_accessor :name, :score, :grade

  # Ruby constructor
  def initialize(name, grade)
    @name = name
    if grade.nil? || grade.empty?
      # There would be a Students model written to connect to the DB using
      # ruby's ORM of choice: Active Record
      @score = Students.where({name: @name}).first.grade
    else
      @score = grade.to_i
    end
    determine_grade
  end

  def determine_grade
    @grade = case @score
    when 90..100  then 'A'
    when 80..89   then 'B'
    when 70..79   then 'C'
    when 60..69   then 'D'
    else 'F'
    end

    unless @grade == 'F'
      @grade << '+' if @score.to_s =~ /^(100|\d(7|8|9))$/
      @grade << '-' if @score.to_s =~ /^\d(0|1|2)$/
    end
    @grade
  end

  def is_honor_roll?
    @grade == 'A+'
  end
end

student_grades  = {"Jack" => "100", "John" => "79", "Terrance" => ""}
honor_roll      = {}

student_grades.each do |key, value|
  student = Student.new(key, value)
  puts "Name: #{student.name} \tGrade: #{student.grade}"
  honor_roll[key] = value if student.is_honor_roll?
end

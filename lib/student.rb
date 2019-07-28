class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id = nil)
    @name = name 
    @grade = grade 
    @id = id
  end 

  def self.create_table 
    sql = <<-SQL
    CREATE TABLE students (
    id INTEGER PRIMARY KEY,
    name TEXT,
    grade INTEGER
      )
    SQL
    DB[:conn].execute(sql)
  end

  #This is a class method that drops the students table. Once again, create a variable `sql`, and set it equal to the SQL statement that drops the students table. 
  #Execute that statement against the database using `DB[:conn].execute(sql)`. 
  
  def self.drop_table
    sql = <<-SQL
      DROP TABLE students;
    SQL
    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade) VALUES (?, ?);
    SQL
    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  def self.create(name: name, grade: grade)
    new_student = Student.new(name, grade)
    new_student.save
    new_student
  end




end 
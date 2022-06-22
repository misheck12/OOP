require 'json'
require_relative './teacher.rb'

def read_people
  file = File.read('people.json') if File.exist?('people.json')
  people = JSON.parse(file) unless file.chomp.empty?
  people&.map do |person|
    if person['class_instance'] == 'Student'
      student = Student.new(person['age'], person['classroom'], person['name'], person['parent_permission'])
      student.id = person['id']
      $application.people.push(student)
    else 
      teacher = Teacher.new(person['age'], person['specialization'], person['name'])
      teacher.id = person['id']
      $application.people.push(teacher)
    end
  end || []
end

def save_data
  save_person
end

def save_person
  peoples_array_data = $application.people.map do |person|
    if person.instance_of?(Teacher)
      { class_instance: 'Teacher', id: person.id, age: person.age, specialization: person.specialization,
      name: person.name }
    else
      { class_instance: 'Student', id: person.id, age: person.age, classroom: person.classroom,
      name: person.name, parent_permission: person.parent_permission } 
    end
  end
  people = JSON.generate(peoples_array_data)
  File.write('people.json', people)
end

def save_book
  books_array = $application.books.map do |book| 
    { class_instance: 'Book', title: book.title, author: book.author }
  end
  books = JSON.generate(books_array)
  File.write('books.json', books)
end
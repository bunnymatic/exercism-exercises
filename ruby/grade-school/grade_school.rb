class School < Hash

  def add(name, grade)
    self[grade] = ((self[grade] || []) << name)
  end

  def students(grade)
    (self[grade] || []).sort
  end

  def students_by_grade
    self.map { |grade, students|
      { grade: grade, students: students.sort }
    }.sort { |a,b|
      a[:grade] <=> b[:grade]
    }
  end

end

module BookKeeping
  VERSION = 3
end
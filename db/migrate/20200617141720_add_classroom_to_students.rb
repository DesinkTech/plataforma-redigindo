class AddClassroomToStudents < ActiveRecord::Migration[6.0]
  def change
    add_reference :students, :classroom, null: false, foreign_key: true
  end
end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

adminRole = Role.create!({ description: "Admin" })
reviewerRole = Role.create!({ description: "Reviewer" })
studentRole = Role.create!({ description: "Student" })

ifrn = Category.create!({ description: "IFRN", max_score: 100 })
enem = Category.create!({ description: "ENEM", max_score: 1000 })

Competence.create!({ description: "ESTRUTURA", category_id: ifrn.id, max_penalty: -20, penalty_division: 4 })
Competence.create!({ description: "ORGANIZAÇÃO L.T.", category_id: ifrn.id, max_penalty: -20, penalty_division: 5 })
Competence.create!({ description: "COESÃO", category_id: ifrn.id, max_penalty: -20, penalty_division: 5 })
Competence.create!({ description: "COERÊNCIA", category_id: ifrn.id, max_penalty: -20, penalty_division: 5 })
Competence.create!({ description: "ARGUMENTAÇÃO", category_id: ifrn.id, max_penalty: -20, penalty_division: 5 })
Competence.create!({ description: "COMP. I", category_id: enem.id, max_penalty: -200, penalty_division: 40 })
Competence.create!({ description: "COMP. II", category_id: enem.id, max_penalty: -200, penalty_division: 40 })
Competence.create!({ description: "COMP. III", category_id: enem.id, max_penalty: -200, penalty_division: 40 })
Competence.create!({ description: "COMP. IV", category_id: enem.id, max_penalty: -200, penalty_division: 40 })
Competence.create!({ description: "COMP. V", category_id: enem.id, max_penalty: -200, penalty_division: 40 })

addr1 = Address.create!({ city: "Apodi", state: "RN" })
addr2 = Address.create!({ city: "Felipe Guerra", state: "RN" })
addr3 = Address.create!({ city: "Mossoró", state: "RN" })

s1 = School.create!({ name: "Colégio Luz Pequeno Príncipe" })
s2 = School.create!({ name: "Colégio Nossa Senhora da Conceição" })
s3 = School.create!({ name: "Instituto Federal de Educação Ciência e Tecnologia - Campus Apodi" })

u1 = User.create!({ email: "thun.der@email.com", username: "Thunder", password: "Chronofox@4dmin", name: "Thun Der",
                   birth_date: "1996-10-28", cpf: "010.752.594-10", rg: "002345691", role_id: adminRole.id,
                   address_id: addr1.id, verified: true, verified_at: DateTime.current })

Admin.create!({ user_id: u1.id })
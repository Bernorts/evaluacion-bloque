# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Role.find_or_create_by(name: 'Administrador')
Role.find_or_create_by(name: 'Profesor')
Role.find_or_create_by(name: 'Estudiante')

# Users
us1 = User.find_or_create_by(name: 'Bernardo', last_name: 'Ortega', email: 'bernorts@gladio.com', password: 'studentpass', role_id: 3)
us2 = User.find_or_create_by(name: 'Martin', last_name: 'Molinero', email: 'A01204818@itesm.com', password: 'adminpass', role_id: 1)
us3 = User.find_or_create_by(name: 'Claud', last_name: 'Robinson', email: 'claud@itesm.com', password: 'professorpass', role_id: 2)
# Semesters
s = Semester.find_or_create_by(name: 'Semestre Enero-Mayo 2018', start_date: '08-01-2018', end_date: '08-05-2018')
us1.semesters << s
us2.semesters << s
us3.semesters << s
# Evaluation
Evaluation.find_or_create_by(reqDate: '21-12-2017', eval_date: '21-12-2017', desLevel: '1', achLevel: '1', competence_id: 1, user_id: 1)
Evaluation.find_or_create_by(reqDate: '21-12-2017', eval_date: '21-12-2017', desLevel: '1', achLevel: '1', competence_id: 2, user_id: 1)
Evaluation.find_or_create_by(reqDate: '21-12-2017', eval_date: '21-12-2017', desLevel: '1', achLevel: '1', competence_id: 3, user_id: 1)
Evaluation.find_or_create_by(reqDate: '21-12-2017', eval_date: '21-12-2017', desLevel: '1', achLevel: '1', competence_id: 4, user_id: 1)
Evaluation.find_or_create_by(reqDate: '21-12-2017', eval_date: '21-12-2017', desLevel: '1', achLevel: '1', competence_id: 5, user_id: 1)
Evaluation.find_or_create_by(reqDate: '21-12-2017', eval_date: '21-12-2017', desLevel: '1', achLevel: '1', competence_id: 6, user_id: 1)
Evaluation.find_or_create_by(reqDate: '21-12-2017', eval_date: '21-12-2017', desLevel: '1', achLevel: '1', competence_id: 7, user_id: 1)
Evaluation.find_or_create_by(reqDate: '21-12-2017', eval_date: '21-12-2017', desLevel: '1', achLevel: '1', competence_id: 8, user_id: 1)
Evaluation.find_or_create_by(reqDate: '21-12-2017', eval_date: '21-12-2017', desLevel: '1', achLevel: '1', competence_id: 9, user_id: 1)

# Competences
Competence.find_or_create_by(name: 'D1')
Competence.find_or_create_by(name: 'D2')
Competence.find_or_create_by(name: 'D3')
Competence.find_or_create_by(name: 'D4')
Competence.find_or_create_by(name: 'T1')
Competence.find_or_create_by(name: 'T2')
Competence.find_or_create_by(name: 'T3')
Competence.find_or_create_by(name: 'T4')
Competence.find_or_create_by(name: 'T5')

# Levels
Level.find_or_create_by(name: 'No conoce la fuerza', order: 0)
Level.find_or_create_by(name: 'Padawan', order: 1)
Level.find_or_create_by(name: 'Jedi', order: 2)
Level.find_or_create_by(name: 'Maestro Jedi', order: 3)
Level.find_or_create_by(name: 'Sith', order: 4)

# Evidences
Evidence.find_or_create_by(name: 'Documento de Especificación de requisitos', url: 'www.drf.com', user_id: 1)
Evidence.find_or_create_by(name: 'Manual de Arquitectura', url: 'www.dan.com', user_id: 1)
Evidence.find_or_create_by(name: 'Modelo Entidad Relación', url: 'www.mer.com', user_id: 1)

# Competence_Level

CompetenceLevel.find_or_create_by(competence_id: 1, level_id: 1)
CompetenceLevel.find_or_create_by(competence_id: 1, level_id: 2)
CompetenceLevel.find_or_create_by(competence_id: 1, level_id: 3)
CompetenceLevel.find_or_create_by(competence_id: 1, level_id: 4)
CompetenceLevel.find_or_create_by(competence_id: 1, level_id: 5)

CompetenceLevel.find_or_create_by(competence_id: 2, level_id: 1)
CompetenceLevel.find_or_create_by(competence_id: 2, level_id: 2)
CompetenceLevel.find_or_create_by(competence_id: 2, level_id: 3)
CompetenceLevel.find_or_create_by(competence_id: 2, level_id: 4)
CompetenceLevel.find_or_create_by(competence_id: 2, level_id: 5)

CompetenceLevel.find_or_create_by(competence_id: 3, level_id: 1)
CompetenceLevel.find_or_create_by(competence_id: 3, level_id: 2)
CompetenceLevel.find_or_create_by(competence_id: 3, level_id: 3)
CompetenceLevel.find_or_create_by(competence_id: 3, level_id: 4)
CompetenceLevel.find_or_create_by(competence_id: 3, level_id: 5)

CompetenceLevel.find_or_create_by(competence_id: 4, level_id: 1)
CompetenceLevel.find_or_create_by(competence_id: 4, level_id: 2)
CompetenceLevel.find_or_create_by(competence_id: 4, level_id: 3)
CompetenceLevel.find_or_create_by(competence_id: 4, level_id: 4)
CompetenceLevel.find_or_create_by(competence_id: 4, level_id: 5)

CompetenceLevel.find_or_create_by(competence_id: 5, level_id: 1)
CompetenceLevel.find_or_create_by(competence_id: 5, level_id: 2)
CompetenceLevel.find_or_create_by(competence_id: 5, level_id: 3)
CompetenceLevel.find_or_create_by(competence_id: 5, level_id: 4)
CompetenceLevel.find_or_create_by(competence_id: 5, level_id: 5)

CompetenceLevel.find_or_create_by(competence_id: 6, level_id: 1)
CompetenceLevel.find_or_create_by(competence_id: 6, level_id: 2)
CompetenceLevel.find_or_create_by(competence_id: 6, level_id: 3)
CompetenceLevel.find_or_create_by(competence_id: 6, level_id: 4)
CompetenceLevel.find_or_create_by(competence_id: 6, level_id: 5)

CompetenceLevel.find_or_create_by(competence_id: 7, level_id: 1)
CompetenceLevel.find_or_create_by(competence_id: 7, level_id: 2)
CompetenceLevel.find_or_create_by(competence_id: 7, level_id: 3)
CompetenceLevel.find_or_create_by(competence_id: 7, level_id: 4)
CompetenceLevel.find_or_create_by(competence_id: 7, level_id: 5)

CompetenceLevel.find_or_create_by(competence_id: 8, level_id: 1)
CompetenceLevel.find_or_create_by(competence_id: 8, level_id: 2)
CompetenceLevel.find_or_create_by(competence_id: 8, level_id: 3)
CompetenceLevel.find_or_create_by(competence_id: 8, level_id: 4)
CompetenceLevel.find_or_create_by(competence_id: 8, level_id: 5)

CompetenceLevel.find_or_create_by(competence_id: 9, level_id: 1)
CompetenceLevel.find_or_create_by(competence_id: 9, level_id: 2)
CompetenceLevel.find_or_create_by(competence_id: 9, level_id: 3)
CompetenceLevel.find_or_create_by(competence_id: 9, level_id: 4)
CompetenceLevel.find_or_create_by(competence_id: 9, level_id: 5)

# Competence_Semester
CompetenceSemester.find_or_create_by(competence_id: 1, semester_id: 1)
CompetenceSemester.find_or_create_by(competence_id: 2, semester_id: 1)
CompetenceSemester.find_or_create_by(competence_id: 3, semester_id: 1)
CompetenceSemester.find_or_create_by(competence_id: 4, semester_id: 1)
CompetenceSemester.find_or_create_by(competence_id: 5, semester_id: 1)
CompetenceSemester.find_or_create_by(competence_id: 6, semester_id: 1)
CompetenceSemester.find_or_create_by(competence_id: 7, semester_id: 1)
CompetenceSemester.find_or_create_by(competence_id: 8, semester_id: 1)
CompetenceSemester.find_or_create_by(competence_id: 9, semester_id: 1)

# CompetenceSemester.find_or_create_by(competence_id: 1, semester_id: 2)
# CompetenceSemester.find_or_create_by(competence_id: 2, semester_id: 2)
# CompetenceSemester.find_or_create_by(competence_id: 3, semester_id: 2)
# CompetenceSemester.find_or_create_by(competence_id: 4, semester_id: 2)
# CompetenceSemester.find_or_create_by(competence_id: 5, semester_id: 2)
# CompetenceSemester.find_or_create_by(competence_id: 6, semester_id: 2)
# CompetenceSemester.find_or_create_by(competence_id: 7, semester_id: 2)
# CompetenceSemester.find_or_create_by(competence_id: 8, semester_id: 2)
# CompetenceSemester.find_or_create_by(competence_id: 9, semester_id: 2)

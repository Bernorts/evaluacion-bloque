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


#Competences
Competence.find_or_create_by(name: 'D1')
Competence.find_or_create_by(name: 'D2')
Competence.find_or_create_by(name: 'D3')
Competence.find_or_create_by(name: 'D4')
Competence.find_or_create_by(name: 'T1')
Competence.find_or_create_by(name: 'T2')
Competence.find_or_create_by(name: 'T3')
Competence.find_or_create_by(name: 'T4')
Competence.find_or_create_by(name: 'T5')

#Levels
Level.find_or_create_by(name: 'No conoce la fuerza')
Level.find_or_create_by(name: 'Padawan')
Level.find_or_create_by(name: 'Jedi')
Level.find_or_create_by(name: 'Maestro Jedi')
Level.find_or_create_by(name: 'Sith')

#Competence_Level

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
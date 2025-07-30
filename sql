Table users {
  id serial [primary key]
  prenom varchar(50)
  nom varchar(50)
  email varchar(100) [unique, not null]
  password text [not null]
  ville varchar(100)
  fonction varchar(100)
  created_at timestamp
}

Table animals {
  id serial [primary key]
  user_id int [not null, ref: > users.id]
  nom varchar(50)
  espece varchar(50)
  race varchar(50)
  sexe varchar(10)
  date_naissance date
  poids_initial decimal(5,2)
  created_at timestamp
}

Table poids_animaux {
  id serial [primary key]
  animal_id int [not null, ref: > animals.id]
  date_mesure date
  poids decimal(5,2)
}

Table vaccinations {
  id serial [primary key]
  animal_id int [not null, ref: > animals.id]
  nom_vaccin varchar(100)
  date_vaccination date
  prochaine_dose date
  remarque text
  created_at timestamp
}

Table traitements {
  id serial [primary key]
  animal_id int [not null, ref: > animals.id]
  date_traitement date
  diagnostic text
  medicament text
  dose varchar(50)
  duree_jours int
  remarque text
  created_at timestamp
}

Table notifications {
  id serial [primary key]
  user_id int [not null, ref: > users.id]
  type varchar(50) // "vaccination", "traitement", "rappel_poids"
  message text
  lu boolean [default: false]
  date_envoi timestamp
}

Table suivis {
  id serial [primary key]
  animal_id int [not null, ref: > animals.id]
  date date
  note text
  humeur varchar(50)
  appetit varchar(50)
  activite varchar(50)
  remarque text
}

User.destroy_all
HabitType.destroy_all
Habit.destroy_all
Tracker.destroy_all

p "started seeding"

user = User.create!(
  email: "tata@tot.fr",
  password: "123456",
  pseudo: "tata",
  avatar: "oooo",
  age: 30,
  location: "BDX"
)


habit_type_clope = HabitType.create!(
  name: "cigarette",
  unit: "cigarettes",
  verb: "arrêter"
)

habit_type_read = HabitType.create!(
  name: "livre",
  unit: "pages",
  verb: "commencer"
)

habit_type_water = HabitType.create!(
  name: "eau",
  unit: "verre",
  verb: "augmenter"
)



habit_clope = Habit.create!(
  user: user,
  name: "Arrêter de fumer dans 6 mois",
  habit_type: habit_type_clope,
  visibility: "public",
  category: "Addictions"
)

habit_read = Habit.create!(
  user: user,
  name: "Lire 4 bouquins cette année",
  habit_type: habit_type_read,
  visibility: "public",
  category: "Bien-être"
)

habit_water = Habit.create!(
  user: user,
  name: "Boire plus d'eau pendant l'été",
  habit_type: habit_type_water,
  visibility: "public",
  category: "Santé"
)


5.times do
  Tracker.create!(
    date: Date.today,
    value: rand(0..5),
    habit: habit_clope
  )
end

5.times do
  Tracker.create!(
    date: Date.today,
    value: rand(0..5),
    habit: habit_read
  )
end

5.times do
  Tracker.create!(
    date: Date.today,
    value: rand(0..5),
    habit: habit_water
  )
end

p "finished seeding"

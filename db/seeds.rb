User.destroy_all
HabitType.destroy_all
Habit.destroy_all

p "started seeding"

user = User.create!(
  email: "tata@tot.fr",
  password: "123456",
  pseudo: "tata",
  avatar: "oooo",
  age: 30,
  location: "BDX"
)
habit_type = HabitType.create!(
  name: "cigarette",
  unit: "cigarettes",
  verb: "arrêter"
)
p habit_type

habit = Habit.create!(
  user: user,
  name: "Arrêter de fumer dans 6",
  habit_type: habit_type,
  visibility: "public",
  category: "Santé"
)

p habit

p "finished seeding"

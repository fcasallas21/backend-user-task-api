user = User.create!(
  email: 'fcasallas21@gmail.com',
  full_name: 'Fabian Casallas',
  role: 'admin'
)

5.times do |i|
  Task.create!(
    title: "Task #{i + 1}",
    description: "Description #{i + 1}",
    status: 'pending',
    due_date: Date.today,
    user: user
  )
end

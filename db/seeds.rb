User.destroy_all

(0..10).to_a.each do |i|
  User.create!(username: "user #{i}", password: 'hi', password_confirmation: 'hi')
end

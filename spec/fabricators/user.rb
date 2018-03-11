Fabricator(:user) do
  username { sequence(:username) { |i| "user-#{i}" } }

  transient password: 'test'
  salt { BCrypt::Engine.generate_salt }
  encrypted_password do |attrs|
    BCrypt::Engine.hash_secret(attrs[:password], attrs[:salt])
  end
end

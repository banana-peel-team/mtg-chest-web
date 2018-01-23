Fabricator(:user) do
  username { sequence(:username) { |i| "user-#{i}" } }
  encrypted_password 'test'
  salt 'test'
end

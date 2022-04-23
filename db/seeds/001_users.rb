User.create_with(
  activated_at: Time.zone.now,
  password: "1password",
  password_confirmation: "1password",
).find_or_create_by!(
  name: "Administrator",
  email: "admin@example.com",
  admin: true,
  activated: true,
)

User.create_with(
  activated_at: Time.zone.now,
  password: "2password",
  password_confirmation: "2password",
).find_or_create_by!(
  name: "User",
  email: "user@example.com",
  admin: false,
  activated: true,
)

User.create_with(
  password: "3password",
  password_confirmation: "3password",
).find_or_create_by!(
  name: "Inactive User",
  email: "inactive_user@example.com",
  admin: false,
  activated: false
)

User.create_with(
  activated_at: Time.zone.now,
  password: "4password",
  password_confirmation: "4password",
).find_or_create_by!( 
  name: "Commish",
  email: "commish@example.com",
  admin: false,
  activated: true,
)

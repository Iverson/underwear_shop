ActiveAdmin.register User do
  index do
    column :id
    column :email
    column :created_at
    default_actions
  end
end

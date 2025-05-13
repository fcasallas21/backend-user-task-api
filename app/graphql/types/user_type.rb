module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :email, String, null: false
    field :full_name, String, null: false
    field :role, String, null: false
    field :tasks, [Types::TaskType], null: true
  end
end
module Types
  class TaskType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :description, String, null: true
    field :status, String, null: false
    field :due_date, String, null: true
    field :user, Types::UserType, null: true

    def due_date
      object.due_date&.strftime("%d/%m/%Y")
    end
  end
end
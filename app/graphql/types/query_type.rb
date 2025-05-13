module Types
  class QueryType < Types::BaseObject
    # Query para usuarios
    # 1
    field :users, [Types::UserType], null: false

    def users
      User.all
    end
    #2
    field :user, Types::UserType, null: true do
      argument :id, ID, required: true
    end

    def user(id:)
      User.find_by(id: id)
    end


    # Query para tareas
    # 1
    field :tasks, [Types::TaskType], null: false

    def tasks
      Task.all
    end

    # 2
    field :task, Types::TaskType, null: true do
      argument :id, ID, required: true
    end

    def task(id:)
      Task.find_by(id: id)
    end
  end
end
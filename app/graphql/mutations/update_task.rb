module Mutations
  class UpdateTask < BaseMutation
    argument :id, ID, required: true
    argument :title, String, required: false
    argument :description, String, required: false
    argument :status, String, required: false
    argument :due_date, String, required: false
    argument :user_id, ID, required: false

    field :task, Types::TaskType, null: true
    field :errors, [String], null: false

    def resolve(id:, **attributes)
      task = Task.find_by(id: id)

      return { task: nil, errors: ["Task not found"] } unless task

      if task.update(attributes)
        { task: task, errors: [] }
      else
        { task: nil, errors: task.errors.full_messages }
      end
    end
  end
end
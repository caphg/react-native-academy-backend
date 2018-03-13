class TodoPresenter
  def as_json(todo)
    {
      id: todo.id,
      title: todo.title,
      description: todo.description
    }
  end
end

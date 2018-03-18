class TodoPresenter
  def as_json(todo)
    {
      id: todo.id,
      title: todo.title,
      description: todo.description,
      contacts: todo_contacts(todo)
    }
  end

  def todo_contacts(todo)
    todo.contacts.map do |c|
      {
        name: c.name,
        phone: c.phone
      }
    end
  end
end

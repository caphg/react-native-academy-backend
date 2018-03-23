class TodoPresenter
  def as_json(todo)
    {
      id: todo.id,
      title: todo.title,
      imageUrl: todo.image_url,
      description: todo.description,
      contacts: todo_contacts(todo)
    }
  end

  def todo_contacts(todo)
    todo.contacts.map do |c|
      {
        id: c.id,
        name: c.name,
        phone: c.phone
      }
    end
  end
end

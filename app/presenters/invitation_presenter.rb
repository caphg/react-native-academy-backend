class InvitationPresenter
  def as_json(invitation)
    {
      id: invitation.id,
      firstUserId: invitation.first_user_id,
      secondUserId: invitation.second_user_id,
      todoId: invitation.todo_id,
      firstUserEmail: first_user_email(invitation),
      todo_title: todo_title(invitation)
    }
  end

  def first_user_email(invitation)
    User.find(invitation.first_user_id).email
  end

  def todo_title(invitation)
    Todo.find(invitation.todo_id).title
  end
end

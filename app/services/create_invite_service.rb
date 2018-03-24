class CreateInviteService
  def initialize(first_user)
    @first_user = first_user
  end

  def call(params)
    second_user = second_user(params)
    raise Invitation::TodoCannotBeShared.new('Todo already shared') if !todo_sharable?(second_user, params[:todo_id])
    raise Invitation::TodoCannotBeShared.new('Invitation already sent') if todo_sent?(second_user, params[:todo_id])
    raise Invitation::TodoCannotBeShared.new(
      'You are owner of this todo, sharing it with others is more fun ;)'
    ) if sharing_with_myself(second_user)
    Invitation.create!(
      first_user_id: @first_user.id,
      second_user_id: second_user.id,
      todo_id: params[:todo_id]
    )
  end

  def second_user(params)
    User.find_by!(email: params[:second_user_email])
  end

  def todo_sharable?(second_user, todo_id)
    !second_user.todos.pluck(:id).include?(todo_id)
  end

  def sharing_with_myself(second_user)
    @first_user.id == second_user.id
  end

  def todo_sent?(second_user, todo_id)
    Invitation
      .where(first_user_id: @first_user.id, second_user_id: second_user.id, todo_id: todo_id)
      .count > 0
  end
end

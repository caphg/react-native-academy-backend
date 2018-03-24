class CreateInviteService
  def initialize(first_user)
    @first_user = first_user
  end

  def call(params)
    second_user = second_user(params)
    raise Invitation::TodoCannotBeSharedError.new('User does not exist') if second_user.blank?
    raise Invitation::TodoCannotBeSharedError.new('Invitation already sent') if todo_sent?(second_user, params[:todo_id])
    raise Invitation::TodoCannotBeSharedError.new(
      'Sharing it with others is more fun ;)'
      ) if sharing_with_myself(second_user)
    raise Invitation::TodoCannotBeSharedError.new('Todo already shared') if !todo_sharable?(second_user, params[:todo_id])

    Invitation.create!(
      first_user_id: @first_user.id,
      second_user_id: second_user.id,
      todo_id: params[:todo_id]
    )
  end

  def second_user(params)
    User.find_by(email: params[:second_user_email])
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

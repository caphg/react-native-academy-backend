class CreateInviteService
  def initialize(first_user)
    @first_user = first_user
  end

  def call(params)
    Invitation.create!(
      first_user_id: @first_user.id,
      second_user_id: second_user(params).id,
      todo_id: params[:todo_id]
    )
  end

  def second_user(params)
    User.find_by!(email: params[:second_user_email])
  end
end

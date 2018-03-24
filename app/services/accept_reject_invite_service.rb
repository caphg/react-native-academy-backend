class AcceptRejectInviteService
  def initialize(first_user)
    @first_user = first_user
  end

  def call(params)
    if params[:accepted]
      @first_user.todos << todo(invitation(params).todo_id)
    end
    invitation(params).destroy!
  end

  def todo(id)
    Todo.find(id)
  end

  def invitation(params)
    @invitation ||= Invitation.find(params[:id])
  end
end

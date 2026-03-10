class Web::UsersController < Web::ApplicationController
  before_action :authenticate_user!

  def profile
    @q = current_user.bulletins
                     .where(state: [ :draft, :published, :archived ])
                     .ransack(params[:q])

    @bulletins = @q.result(distinct: true)
                   .order(created_at: :desc)
                   .page(params[:page])
                   .per(20)

    @aasm = Bulletin.aasm.states
  end
end

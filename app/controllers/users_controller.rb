class UsersController < AdminController
  inherit_resources

  protected

  def collection
    @users ||= end_of_association_chain.paginate(
      :page     => params[:page],
      :per_page => Settings.collection.per_page
    )
  end
end

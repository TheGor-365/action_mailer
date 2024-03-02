module PostNotifier
  extend ActiveSupport::Concern

  included do
    after_action :notify_users, only: [:create]
  end

  private

  def notify_users
    if @post.persisted?
      puts 'Sending email to all users'

      User.where.not(id: @post.user_id).each do |user|
        PostMailer.new_post_email(user, @post).deliver_later
      end
    end
  end
end

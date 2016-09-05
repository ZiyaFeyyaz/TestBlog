class CommentMailer < ApplicationMailer

  def notify(article, comment)
    @article = article
    @comment = comment
    mail(subject: 'Added new comment')
  end
end

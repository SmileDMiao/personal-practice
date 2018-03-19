class PostsWorker

  include Sneakers::Worker

  from_queue 'rabcus.posts', env: nil

  def work(row_post)
    puts '*' * 18
    puts row_post
    ack!
  end

en
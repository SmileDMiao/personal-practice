# frozen_string_literal: true

namespace :rabbitmq do

  desc "setup routing"

  task :setup do
    require "bunny"
    conn = Bunny.new
    conn.start

    ch = conn.create_channel

    x = ch.fanout("Article.Articles")

    queue = ch.queue("rabcus.posts", durable: true)

    queue.bind("Article.Articles")
    conn.close
  end

end

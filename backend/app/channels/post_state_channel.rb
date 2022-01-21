class PostStateChannel < ApplicationCable::Channel
  def subscribed
    stream_from "post_state_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def post(data)
    ActionCable.server.broadcast "PostStateChannel", message: data['message']
  end
end

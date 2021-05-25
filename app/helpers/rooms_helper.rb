module RoomsHelper
  def most_new_message_preview(room)
    message = room.messages.order(updated_at: :desc).first
    tag.p message.message.to_s, class: "block mb-5" if message.present?
  end
end

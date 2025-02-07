# frozen_string_literal: true

# Helper for creating links
module LinkHelper
  def link_to_youtube(channel_id, **)
    youtube_path = "https://www.youtube.com/channel/#{channel_id}"
    link_to(youtube_path, youtube_path, target: '_blank', rel: 'noopener', **)
  end
end

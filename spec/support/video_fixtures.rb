# frozen_string_literal: true

def video_snippet_fixture(video_id: nil)
  {
    'etag' => SecureRandom.uuid,
    'id' => {
      'kind' => 'youtube#video',
      'videoId' => video_id || SecureRandom.uuid
    },
    'kind' => 'youtube#searchResult',
    'snippet' => {
      'channelId' => channel_id_fixture,
      'channelTitle' => channel_title_fixture,
      'description' => '',
      'liveBroadcastContent' => 'none',
      'publishedAt' => '2023-07-21T23 =>42 =>29Z',
      'thumbnails' => {
        'default' => {
          'height' => 90,
          'url' => "https://i.ytimg.com/vi/#{video_id || SecureRandom.uuid}/default.jpg",
          'width' => 120
        },
        'high' => {
          'height' => 360,
          'url' => "https://i.ytimg.com/vi/#{video_id || SecureRandom.uuid}/hqdefault.jpg",
          'width' => 480
        },
        'medium' => {
          'height' => 180,
          'url' => "https://i.ytimg.com/vi/#{video_id || SecureRandom.uuid}/mqdefault.jpg",
          'width' => 320
        }
      },
      'title' => 'Enumeration'
    }
  }
end

def video_title_fixture
  'DLSS Awesome Demo Video'
end

def video_details_fixture(video_id: nil)
  {
    'items' => [{
      'channelId' => channel_id_fixture,
      'channelTitle' => channel_title_fixture,
      'description' => video_title_fixture,
      'liveBroadcastContent' => 'none',
      'publishedAt' => '2017-07-31T21:34:02Z',
      'thumbnails' => {
        'default' => {
          'height' => 90,
          'url' => 'https://i.ytimg.com/vi/4u3yzmNWeqs/default.jpg',
          'width' => 120
        },
        'high' => {
          'height' => 360,
          'url' => 'https://i.ytimg.com/vi/4u3yzmNWeqs/hqdefault.jpg',
          'width' => 480
        },
        'medium' => {
          'height' => 180,
          'url' => 'https://i.ytimg.com/vi/4u3yzmNWeqs/mqdefault.jpg',
          'width' => 320
        }
      },
      'title' => video_title_fixture,
      'contentDetails' => {
        'caption' => 'false',
        'content_rating' => {},
        'definition' => 'hd',
        'dimension' => '2d',
        'duration' => 'PT2M5S',
        'licensed_content' => false,
        'projection' => 'rectangular'
      },
      'etag' => SecureRandom.uuid,
      'id' => video_id || SecureRandom.uuid,
      'kind' => 'youtube#video',
      'statistics' => {
        'favorite_count' => 0,
        'like_count' => 0,
        'view_count' => 134
      }
    }]
  }
end

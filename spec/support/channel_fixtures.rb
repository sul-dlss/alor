# frozen_string_literal: true

def channel_id_fixture
  # This is a fixture for a YouTube channel ID.
  # It can be used in tests to simulate fetching data for a specific channel.
  'ABa1CDbEcdFGH-2IJKLMNO2P'
end

def channel_title_fixture
  'DLSS Example YouTube Channel'
end

def channel_data_fixture
  {
    'etag' => SecureRandom.uuid,
    'kind' => 'youtube#channelListResponse',
    'items' => [
      {
        'id' => channel_id_fixture,
        'etag' => SecureRandom.uuid,
        'kind' => 'youtube#channel',
        'snippet' => {
          'title' => channel_title_fixture,
          'customUrl' => '@dlssexamplechannel',
          'localized' => { 'title' => channel_title_fixture, 'description' => '' },
          'thumbnails' => {
            'high' => { 'url' => 'https://yt3.ggpht.com/ytc/EXAMPLE=s800', 'width' => 800, 'height' => 800 },
            'medium' => { 'url' => 'https://yt3.ggpht.com/ytc/EXAMPLE=s240', 'width' => 240, 'height' => 240 },
            'default' => { 'url' => 'https://yt3.ggpht.com/ytc/EXAMPLE=s88', 'width' => 88, 'height' => 88 }
          },
          'description' => '',
          'publishedAt' => '2014-02-07T18:55:51Z'
        }
      }
    ],
    'pageInfo' => { 'totalResults' => 1, 'resultsPerPage' => 5 }
  }
end

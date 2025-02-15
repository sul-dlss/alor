# frozen_string_literal: true

require 'config'
require 'debug'

require_relative '../../config/boot'

namespace :report do
  task :captions, [:channel_id] => :environment do |_t, args|
    args.with_defaults(channel_id: Settings.youtube.channel_id)
    puts "Channel ID: #{args[:channel_id]}"

    Youtube::ReportRunner.new(channel_id: args[:channel_id]).caption_report_for_channel
  end
end

# frozen_string_literal: true

# Controller for a Channel
class ChannelsController < ApplicationController
  before_action :set_channel, only: %i[show edit update destroy refresh]

  def show
    authorize! @channel
  end

  def new
    authorize Channel
    @channel_form = ChannelForm.new

    render :form
  end

  def edit
    authorize! @channel

    render :form
  end

  def create
    authorize Channel
    @channel_form = ChannelForm.new(**channel_params)

    if @channel_form.valid?(save: save?)
      channel = Channel.create!(channel_id: @channel_form.channel_id, title: @channel_form.title)
      redirect_to channels_path(channel.id)
    else
      render :form, status: :unprocessable_entity
    end
  end

  def update
    authorize! @channel

    @channel_form = ChannelForm.new(**update_channel_params)
    # The deposit param determines whether extra validations for deposits are applied.
    if @channel_form.valid?(save: save?)
      @channel.update!(channel_id: @channel_form.channel_id, title: @channel_form.title)
      redirect_to channels_path(channel.id)
    else
      render :form, status: :unprocessable_entity
    end
  end

  def refresh
    authorize! @channel
    FetchChannelJob.perform_later(channel_id: @channel.channel_id)
    redirect_to channel_path(@channel.channel_id)
  end

  def destroy
    authorize! @channel

    @channel.destroy!
    redirect_to root_path
  end

  private

  def channel_params
    params.expect(channel: ChannelForm.user_editable_attributes)
  end

  def update_channel_params
    channel_params.merge(channel_id: params[:channel_id])
  end

  def save?
    params[:commit] == 'Save'
  end

  def set_channel
    @channel = Channel.find_by!(channel_id: params[:channel_id])
  end
end

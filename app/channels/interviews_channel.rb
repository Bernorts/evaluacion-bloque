# frozen_string_literal: true

class InterviewsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'interviews'
  end
end

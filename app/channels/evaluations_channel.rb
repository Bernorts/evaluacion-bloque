class EvaluationsChannel < ApplicationCable::Channel  
	def subscribed
    	stream_from 'evaluations'
  	end
end  
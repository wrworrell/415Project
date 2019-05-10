class PollResponse < ApplicationRecord
  belongs_to :user
  belongs_to :poll
end

class MultiChoicePollResponse < PollResponse
  def response
    r = read_attribute(:response)
    self.poll.options.index(r)
  end
end

class FreeResponsePollResponse < PollResponse
end

class NumericPollResponse < PollResponse
  def response
    read_attribute(:response).to_f
  end
end

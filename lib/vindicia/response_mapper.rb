module Vindicia::ResponseMapper
  def self.map(response)
    case response['object']
    when 'List'
      response['data'].map {|d| map(d) }
    when 'Error'
      puts response
    else
      "Vindicia::Model::#{response['object']}".constantize.new(response)
    end
  end
end

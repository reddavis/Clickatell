module Clickatell
  
  class Text
    def initialize(username, password, api_id)
      @username, @password, @api_id = username, password, api_id
    end
  
    def send(to, message)
      url = send_url(to, message)
      response = Typhoeus::Request.get(url)
      respond(response)
    end
  
    private
  
    def send_url(to, message)
      "https://api.clickatell.com/http/sendmsg?user=#{@username}&password=#{@password}&api_id=#{@api_id}&to=#{to}&text=#{URI.escape(message)}"
    end
    
    def respond(response)
      case response.code
      when 200
        true
      when 001
        raise AuthenticationFailed.new(response.body)
      when 002
        raise UnknownUsernameOrPassword.new(response.body)
      when 004
        raise AccountFrozen.new(response.body)
      when 007
        raise IPLockdownViolation.new(response.body)
      when 106
        raise InvalidNumber.new(response.body)
      when 107
        raise EmptyMessage.new(response.body)
      when 108
        raise InvalidAPIID.new(response.body)
      when 113
        raise MessageTooLong.new(response.body)
      when 121
        raise NumberBlocked.new(response.body)
      when 128
        raise NumberDelisted.new(response.body)
      when 301
        raise NoCreditLeft.new(response.body)
      when 302
        raise MaxAllowedCredit.new(response.body)
      else
        raise UnknownError.new("#{response.code} - #{response.body}")
      end
    end
  end
  
end
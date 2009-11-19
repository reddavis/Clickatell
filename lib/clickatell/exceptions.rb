module Clickatell
  
  class AuthenticationFailed < Exception
  end
  
  class UnknownUsernameOrPassword < Exception
  end
  
  class AccountFrozen < Exception
  end
  
  class IPLockdownViolation < Exception
  end
  
  class InvalidNumber < Exception
  end
  
  class EmptyMessage < Exception
  end
  
  class InvalidAPIID < Exception
  end
  
  class MessageTooLong < Exception
  end
  
  class NumberBlocked < Exception
  end
  
  class NumberDelisted < Exception
  end
  
  class NoCreditLeft < Exception
  end
  
  class MaxAllowedCredit < Exception
  end
  
  class UnknownError < Exception
  end
  
end
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Clickatell" do
  
  describe "Sending Texts" do
    before do
      response = Typhoeus::Response.new(:code => 200)
      Typhoeus::Request.stub!(:get).and_return(response)
      @a = start_clickatell
    end
  
    it "should send text" do
      Typhoeus::Request.should_receive(:get)
      @a.send(444, 'sometext')
    end
    
    it "should return true" do
      @a.send(444, 'yer').should be_true
    end
  end
  
  describe "Error Handling" do
    
    describe "Authentication Fail" do
      before do
        response = build_response(001)
        Typhoeus::Request.stub!(:get).and_return(response)
        @a = start_clickatell
      end
      
      it "should raise an AuthenticationFailed exception" do
        lambda do
          @a.send(444, 'test')
        end.should raise_error(Clickatell::AuthenticationFailed)
      end
    end
    
    describe "Unknown Username or Password" do
      before do
        response = build_response(002)
        Typhoeus::Request.stub!(:get).and_return(response)
        @a = start_clickatell
      end
      
      it "should raise an UnknownUsernameOrPassword exception" do
        lambda do
          @a.send(444, 'test')
        end.should raise_error(Clickatell::UnknownUsernameOrPassword)
      end
    end
    
    describe "Account Frozen" do
      before do
        response = build_response(004)
        Typhoeus::Request.stub!(:get).and_return(response)
        @a = start_clickatell
      end
      
      it "should raise an AccountFrozen exception" do
        lambda do
          @a.send(444, 'test')
        end.should raise_error(Clickatell::AccountFrozen)
      end
    end
    
    describe "IP Lockdown Violation" do
      before do
        response = build_response(007)
        Typhoeus::Request.stub!(:get).and_return(response)
        @a = start_clickatell
      end
      
      it "should raise an IPLockdownViolation exception" do
        lambda do
          @a.send(444, 'test')
        end.should raise_error(Clickatell::IPLockdownViolation)
      end
    end
    
    describe "Invalid Number" do
      before do
        response = build_response(106)
        Typhoeus::Request.stub!(:get).and_return(response)
        @a = start_clickatell
      end
      
      it "should raise an InvalidNumber exception" do
        lambda do
          @a.send(444, 'test')
        end.should raise_error(Clickatell::InvalidNumber)
      end
    end
    
    describe "Empty Message" do
      before do
        response = build_response(107)
        Typhoeus::Request.stub!(:get).and_return(response)
        @a = start_clickatell
      end
      
      it "should raise an EmptyMessage exception" do
        lambda do
          @a.send(444, 'test')
        end.should raise_error(Clickatell::EmptyMessage)
      end
    end
    
    describe "Invalid Or Missing API ID" do
      before do
        response = build_response(108)
        Typhoeus::Request.stub!(:get).and_return(response)
        @a = start_clickatell
      end
      
      it "should raise an InvalidAPIID exception" do
        lambda do
          @a.send(444, 'test')
        end.should raise_error(Clickatell::InvalidAPIID)
      end
    end
    
    describe "Message Too Long" do
      before do
        response = build_response(113)
        Typhoeus::Request.stub!(:get).and_return(response)
        @a = start_clickatell
      end
      
      it "should raise an MessageTooLong exception" do
        lambda do
          @a.send(444, 'test')
        end.should raise_error(Clickatell::MessageTooLong)
      end
    end
    
    describe "Number Blocked" do
      before do
        response = build_response(121)
        Typhoeus::Request.stub!(:get).and_return(response)
        @a = start_clickatell
      end
      
      it "should raise an NumberBlocked exception" do
        lambda do
          @a.send(444, 'test')
        end.should raise_error(Clickatell::NumberBlocked)
      end
    end
    
    describe "Number Delisted" do
      before do
        response = build_response(128)
        Typhoeus::Request.stub!(:get).and_return(response)
        @a = start_clickatell
      end
      
      it "should raise an NumberDelisted exception" do
        lambda do
          @a.send(444, 'test')
        end.should raise_error(Clickatell::NumberDelisted)
      end
    end
    
    describe "No Credit Left" do
      before do
        response = build_response(301)
        Typhoeus::Request.stub!(:get).and_return(response)
        @a = start_clickatell
      end
      
      it "should raise an NoCreditLeft exception" do
        lambda do
          @a.send(444, 'test')
        end.should raise_error(Clickatell::NoCreditLeft)
      end
    end
    
    describe "Max Allowed Credit" do
      before do
        response = build_response(302)
        Typhoeus::Request.stub!(:get).and_return(response)
        @a = start_clickatell
      end
      
      it "should raise an MaxAllowedCredit exception" do
        lambda do
          @a.send(444, 'test')
        end.should raise_error(Clickatell::MaxAllowedCredit)
      end
    end
    
    describe "Unknown Error" do
      before do
        response = build_response(999)
        Typhoeus::Request.stub!(:get).and_return(response)
        @a = start_clickatell
      end
      
      it "should raise an UnknownError exception" do
        lambda do
          @a.send(444, 'test')
        end.should raise_error(Clickatell::UnknownError)
      end
    end
    
  end
  
  private
  
  def start_clickatell
    Clickatell::Text.new('username', 'password', 'api_id')
  end
  
  def build_response(code)
    Typhoeus::Response.new(:code => code)
  end
  
end

require "request_handler"

describe RequestHandler do
  let(:request) { {"Body" => {"testclass" => "stuff"}}}

  describe "create" do
    it "is a class of type Testclass" do
      handler = RequestHandler.create(request)
      handler.should be_an_instance_of TestclassHandler
    end

    it "is NilHandler when class not found" do
      handler = RequestHandler.create({})
      handler.should be_an_instance_of NilHandler
    end
  end

  describe "find_key" do
    it "is the first key in the body of the request" do
      RequestHandler.find_key(request).should == "testclass"
    end

    it "is an empty string if there is no body" do
      RequestHandler.find_key({}).should == ""
    end
  end

  describe "format_name" do
    it "is StuffHandler for stuff" do
      RequestHandler.format_name("stuff").should == "StuffHandler"
    end

    it "is an empty string for an empty string" do
      RequestHandler.format_name("").should == ""
    end
  end
end

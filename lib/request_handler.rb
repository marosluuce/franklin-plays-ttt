require "nil_handler"

class RequestHandler
  def self.create(request)
    name = find_key(request)
    begin
      require "#{name}_handler"
      Module.const_get(format_name(name)).new
    rescue NameError, LoadError
      NilHandler.new
    end
  end

  def self.find_key(request)
    request["Body"].keys.first
  rescue
    ""
  end

  def self.format_name(name)
    name.length > 0 ? "#{name.capitalize}Handler" : ""
  end
end

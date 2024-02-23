# This code allows any service to inherit the call function,
# which is responsible for instantiating the service and calling the call method itself.

class ApplicationService
  def self.call(*args)
    new(*args).call
  end
end

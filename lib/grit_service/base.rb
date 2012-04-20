require 'logger'

module GritService
  def self.git(git_dir)
    @gits ||= {}
    @gits[git_dir] ||= Grit::Git.new(git_dir)
  end

  def self.log
    @logger ||= Logger.new('/tmp/grit_service.log')
  end

  def self.bertrpc(host = 'localhost', port = 9999)
    @bertrpc ||= BERTRPC::Service.new(host, port)
  end

  module Helpers
    def service(method)
      define_method(method) do |git_dir, *args|
        GritService.log.debug("#{GritService.git(git_dir)}: #{method}(#{args.inspect})")
        begin
          GritService.git(git_dir).send(method, *args)
        rescue Exception => e
          GritService.log.error(e.to_s)
          e.backtrace.each {|line| GritService.log.error(line)}
          raise e
        end
      end
    end
  end
end

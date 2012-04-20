require 'rubygems'
require 'ernie'
require 'grit'
require 'grit_service/base'

module GritService
  module Service
    module Git
      extend GritService::Helpers

      service :exist?
      service :put_raw_object
      service :get_raw_object
      service :get_git_object
      service :object_exists?
      service :select_existing_objects
      service :fs_exist?
      service :fs_read
      service :fs_write
      service :fs_delete
      service :fs_move
      service :fs_mkdir
      service :fs_chmod
      service :list_remotes
      service :create_tempfile
      service :commit_from_sha
      service :check_applies
      service :get_patch
      service :apply_patch

      def native(git_dir, cmd, *args)
        GritService.log.debug("#{GritService.git(git_dir)}: #{cmd}(#{args.inspect})")
        GritService.git(git_dir).send(cmd, *args)
      rescue Exception => e
        GritService.log.error(e.to_s)
        e.backtrace.each {|line| GritService.log.error(line)}
        raise e
      end
    end
  end
end

Ernie.expose(:git, GritService::Service::Git)

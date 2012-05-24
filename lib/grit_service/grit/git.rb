module Grit
  class Git
    def self.service(method)
      define_method(method) do |*args|
        GritService.bertrpc.call.git.send(method, *([self.git_dir, args].flatten))
      end
    end

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

    # we need to undef all of the GitRuby methods so native sends them on
    undef :init
    undef :cat_file
    undef :cat_ref
    undef :ls_tree
    undef :diff
    undef :rev_list
    undef :rev_parse
    undef :refs
    undef :tags
    undef :file_size
    undef :file_type

    # override native to send rpc
    def native(cmd, options = {}, *args, &block)
      GritService.bertrpc.call.git.native(self.git_dir, cmd, options, *args)
    end

    # not sure why I need to do this but doing it on console
    # commands returned correct results...
    def method_missing(cmd, options = {}, *args, &block)
      native(cmd, options, *args)
    end
  end # Git
end # Grit

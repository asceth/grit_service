require 'rubygems'
gem 'ernie'
require 'ernie'

mod(:git) do
  Grit::Git.service_methods.each do |method|
    fun(method) do |git_dir, *args|
      Grit::Git.repo(git_dir).send(method, *args)
    end
  end
end

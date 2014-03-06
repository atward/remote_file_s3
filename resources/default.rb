default_action :create
actions :create, :create_if_missing, :touch, :delete

attribute :path, :kind_of => String, :name_attribute => true
attribute :remote_path, :kind_of => String
attribute :bucket, :kind_of => String
attribute :aws_access_key_id, :kind_of => String
attribute :aws_secret_access_key, :kind_of => String
attribute :owner, :regex => Chef::Config[:user_valid_regex]
attribute :group, :regex => Chef::Config[:group_valid_regex]
attribute :mode, :kind_of => [Integer, String, NilClass], :default => nil
attribute :checksum, :kind_of => [String, NilClass], :default => nil
attribute :backup, :kind_of => [Integer, FalseClass], :default => 5
attribute :use_etag, :kind_of => [TrueClass, FalseClass], :default => true
attribute :use_last_modified, :kind_of => [TrueClass, FalseClass], :default => true
attribute :sensitive :kind_of => [TrueClass, FalseClass], :default => nil
if Platform.windows?
  attribute :inherits, :kind_of => [TrueClass, FalseClass], :default => true
  attribute :rights, :kind_of => Hash, :default => nil
end
attribute :atomic_update, :kind_of => [TrueClass, FalseClass], :default => true
attribute :force_unlink, :kind_of => [TrueClass, FalseClass], :default => false
attribute :manage_symlink_source, :kind_of => [TrueClass, FalseClass], :default => nil

def initialize(*args)
  version = Chef::Version.new(Chef::VERSION[/^(\d+\.\d+\.\d+)/, 1])
  if version.major < 10 # || ( version.major == 11 && version.minor < 6 )
    raise "this s3_file provider is not supported on Chef < 11.6.0"
  end
  super
  @path = name
end

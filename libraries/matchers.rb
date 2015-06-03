if defined?(ChefSpec)
  def create_remote_file_s3(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:remote_file_s3, :create, resource_name)
  end
end

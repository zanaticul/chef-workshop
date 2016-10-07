
include_recipe "apt"
include_recipe 'tarball::default'

node['abc-app']['dependencies'].each do |dep_pck|
  package dep_pck
end

# Fetch the tarball if it's not a local file
remote_file '/tmp/wordpress' do
  source node['abc-app']['wordpress_url']
end

tarball '/tmp/wordpress' do
  destination '/var/www/'
  owner 'root'
  group 'root'
  #extract_list [ '*.conf' ]
  action :extract
end

directory '/var/www/wordpress' do
  owner 'root'
  group 'root'
  mode '0755'
end

link '/etc/apache2/mods-enabled/rewrite.load' do
  to '/etc/apache2/mods-available/rewrite.load'
end

['uploads','plugins', 'themes'].each do |folder|
	directory '/var/www/wordpress/wp-content/' + folder do
	  owner 'www-data'
	  group 'www-data'
	  mode '0700'
	end
end

template '/var/www/wordpress/wp-config.php' do
  source 'wp-config.erb'
  owner 'root'
  group 'root'
  mode '0755'
  variables ( { :wpconfig => node['abc-app']['wpconfig'] } )
end

template '/etc/apache2/sites-enabled/wordpress.conf' do
  source 'wordpress_virtualhost.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

service "apache2" do
  action :restart
end
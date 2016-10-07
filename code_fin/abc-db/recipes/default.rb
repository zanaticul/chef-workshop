mysql_connection_info = node['abc-mysql']['connection_info']

# Configure the MySQL client.
mysql_client 'default' do
  action :create
end

# Configure the MySQL service.
mysql_service 'default' do
  initial_root_password "SuperSecretPassword"
  socket "/var/run/mysqld/mysqld.sock"
  action [:create, :start]
end

# Install the mysql2 Ruby gem.
mysql2_chef_gem 'default' do
  action :install
end

mysql_database 'wordpress' do
  connection mysql_connection_info
  action :create
end

mysql_database_user 'wordpress' do
  connection mysql_connection_info
  password      'wordpress'
  database_name 'wordpress'
  host          '%'
  privileges    [:select,:update,:insert]
  action        :grant
end

mysql_database 'wordpress' do
  connection mysql_connection_info
  sql        'flush privileges'
  action     :query
end

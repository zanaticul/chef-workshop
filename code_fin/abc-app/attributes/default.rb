default['abc-app']['wordpress_url'] = "http://wordpress.org/latest.tar.gz"
default['abc-app']['dependencies'] = ['php5','php5-gd','php5-mysql','libssh2-php', 'apache2', 'libapache2-mod-php5', 'php5-curl']
default['abc-app']['wpconfig'] = {

	:db_name => 'wordpress',
	:username => 'wordpress',
	:password => 'wordpress',
	:hostname => 'abc-dev-db.funit.ro'
}

default['abd-app']['hostname'] = 'abc-dev.funit.ro'

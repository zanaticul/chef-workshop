require 'spec_helper'

describe 'abc-app::default' do
  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html
	describe command('ls /etc/apache2/sites-enabled/wordpress.conf') do
	  its(:exit_status) { should eq 0 }
	end

    describe command('ls /var/www/wordpress/wp-config.php') do
	  its(:exit_status) { should eq 0 }
	end

	describe command('apachectl -M') do
	  its(:stdout) { should contain('rewrite') }
	end
end

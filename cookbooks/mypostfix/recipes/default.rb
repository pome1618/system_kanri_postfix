#
# Cookbook:: mypostfix
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

#open smtp(25) and imap(143) by firewall-cmd
bash 'firewall setting' do
  code <<-EOC
    firewall-cmd --permanent --add-service=smtp
    firewall-cmd --permanent --add-service=imaps
    firewall-cmd --reload
    firewall-cmd --list-all
  EOC
end

#create mailing list
bash 'mailing list' do
  code <<-EOC
    echo "member:  b1015260,b1015261,b1015262,group05" >> /etc/aliases
    newaliases
  EOC
end

#receiving mails from outside
bash 'inet_interfaces setting' do
  user "root"
#  code <<-EOC
#    cat /etc/postfix/main.cf|sed -e 's/inet_interfaces = localhost/inet_interfaces = all/g'>/etc/postfix/main.cf
#  EOC
  code <<-EOC
    cat /etc/postfix/main.cf|sed -e 's/inet_interfaces = localhost/inet_interfaces = all/g' > /etc/postfix/main.cf2
    mv /etc/postfix/main.cf2 /etc/postfix/main.cf
  EOC
end


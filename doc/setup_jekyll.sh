sudo apt-get install ruby-dev
sudo apt-get install git
cd /opt
git clone https://github.com/rubygems/rubygems.git
cd rubygems
git submodule update --init
gem install jekyll

sudo apt-get install apache2
service apache2 start

# cd /var/www/html/
# scp -r /cooo root@233.233.233.233:/var/www/html
# https://help.aliyun.com/document_detail/25475.html?spm=5176.2020520101.0.0.33d44df5laJcVt
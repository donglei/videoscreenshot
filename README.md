# ffmpge环境安装
	-- apt-get install libavfilter-dev libavcodec-dev libavformat-d 
	
	Debian Jessie 用户安装
因为有库源，依然很简单，打开终端，输入以下命令：
sudo sh -c 'echo "deb http://www.deb-multimedia.org jessie main" >> /etc/apt/sources.list'
sudo apt-get update
sudo apt-get install deb-multimedia-keyring
sudo apt-get install ffmpeg
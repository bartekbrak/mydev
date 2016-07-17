Vagrant.configure("2") do |config|
  # https://atlas.hashicorp.com/gbarbieru/boxes/xenial/
  # bit.ly/1SUfK3b
  config.vm.box = "gbarbieru/xenial"

  # alternatively, the bugged official Ubuntu box, bare and not working
  # config.vm.box = "xenial64"
  # https://bugs.launchpad.net/ubuntu/+source/livecd-rootfs/+bug/1561250
  # config.vm.box_url = "http://cloud-images.ubuntu.com/xenial/current/xenial-server-cloudimg-amd64-vagrant.box"

  config.vm.synced_folder "files", "/files"

  config.vm.provider "virtualbox" do |vb|
     vb.memory = "2048"
  end
  #config.vm.provision "shell", path: "setup_the_machine.bash", privileged: false
end

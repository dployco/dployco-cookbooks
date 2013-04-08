default['dployco']['sysctl'] = Mash.new
default['dployco']['sysctl']['net.core.somaxconn'] = 1024           # 128
default['dployco']['sysctl']['net.core.netdev_max_backlog'] = 3072  # 1000
default['dployco']['sysctl']['net.ipv4.tcp_max_syn_backlog'] = 2048 # 1024
default['dployco']['sysctl']['net.ipv4.tcp_fin_timeout'] = 30       # 60
default['dployco']['sysctl']['net.ipv4.tcp_keepalive_time'] = 1024  # 7200
default['dployco']['sysctl']['net.ipv4.tcp_max_orphans'] = 131072   # 32768
default['dployco']['sysctl']['net.ipv4.tcp_tw_reuse'] = 1           # 0

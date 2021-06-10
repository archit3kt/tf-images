# Dash Node

This image will start a Dash full node 

### How to build from the Dockerfile ?

```
git clone https://github.com/threefoldtech/tf-images.git
cd dash
docker build --tag dash:latest .
```
Sit back and relax then ! It should be quicker and you should see a successful message as below,

```
 ---> d0de06934f0c
Step 17/17 : EXPOSE 12024 14022
 ---> Running in 030f3afef72c
Removing intermediate container 030f3afef72c
 ---> 0781ccba23e2
Successfully built 0781ccba23e2
Successfully tagged dgb:1.1
```

### Startup Script / EntryPoint

This should be found here [ENTRYPOINT](scripts/start_dash.sh)

### Environment Variables

These would be required by the user to interact with the node by sending commands via rpc

* rpcuser (The node RPC credentials user/pass)
* rpcpasswd

### How to run ?

You can then spin the container with your created image. Map host ports as needed,

```docker run -dit --name=dash --hostname=dash -p 9999:9999 -p 9998:9998 dgb:latest bash```
 
### How to verify ?

The node displays running services via status page that runs on the HTTP port. It should be accessible by,

```http://your_ip_address```

Get into the container with,

```docker exec -it dash bash```

Verify the node runnning by checking the dash process, you could see it running as below

```
root@dash:/dash# netstat -lntpe
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       User       Inode      PID/Program name
tcp        0      0 0.0.0.0:9999            0.0.0.0:*               LISTEN      0          25022620   27/dashd
tcp        0      0 0.0.0.0:9998            0.0.0.0:*               LISTEN      0          25022615   27/dashd
tcp6       0      0 :::9999                 :::*                    LISTEN      0          25022619   27/dashd
tcp6       0      0 :::22                   :::*                    LISTEN      0          25022674   1/sshd
```


The default data directory for Dash is /dash where you will see all Dash data,

```
root@dash:/dash# tree -dh
.
|-- [4.0K]  blocks
|   `-- [4.0K]  index
|-- [4.0K]  chainstate
`-- [4.0K]  database

4 directories
```


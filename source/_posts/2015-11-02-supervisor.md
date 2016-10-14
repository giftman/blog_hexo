---
title: Supervisor
date: 2015/11/02 20:46:25
banner: http://oeyxehw3i.bkt.clouddn.com/16-10-14/88226207.jpg
tags:
- unix
- server
- tools
- supervisor
categories:
- Tools
---

- <http://supervisord.org/running.html>

## The simple way to use suepervisor



### Install 
```bash
pip install supervisor
```
### create default config 
```bash
echo_supervisord_conf > supervisord.conf
```
### supervisord(start)  
```bash
supervisord -n -c supervisor.conf 
```

### supervisorctl (controller)
```bash
supervisorctl status/stop all/shutdown 
```

### add program 
```
[program:foo]
command=/bin/cat              ; the program (relative uses PATH, can take args)

[program:goagent]
command=/usr/local/bin/python proxy.py              ; the program (relative uses PATH, can take args)
directory=/Users/winfan/opt/goagent/local                ; directory to cwd to before exec (def no cwd)

```

```bash
supervisorctl reload
```

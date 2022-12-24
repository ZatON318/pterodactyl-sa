# Pterodactyl
I created these eggs and yolks because I started using processors with ARM architecture, but most of the games and software that Pterodactyl Panel ran with the official eggs and yolks did not support ARM but rather AMD so I based on the eggs. and original buds and thanks to a bit of knowledge that I have I managed to create this incredible collection compatible with ARM and AMD that I will update as I go.

# Eggs and Yolks
* [`egg-mta.json`](/eggs/egg-mta.json) — [`Multi Theft Auto`](https://multitheftauto.com)
	* `ghcr.io/daniscript18/yolks:mta`
	
* [`egg-samp.json`](/eggs/egg-samp.json) — [`San Andreas Multiplayer`](https://sa-mp.com)
	* `ghcr.io/daniscript18/yolks:samp`
	
* [`egg-terraria.json`](/eggs/egg-terraria.json) — [`Terraria`](https://terraria.org)
	* `ghcr.io/daniscript18/yolks:terraria`

# Bug
I have a problem with SA-MP, it happens that when you start it with box86 and then you want to stop the server using ^C it doesn't work, so I changed ^C to ^^C but that just forcefully shuts down the server.

For this problem there are two "solutions" they are just alternatives to shut down the server correctly while I figure out how to solve this problem. The first solution is to create a command on your server that allows you to shut it down with the RCON "exit" command, something like ```SendRconCommand("exit");```

We can also use the RCON console remotely, for that we go to the root folder of our game, where we have gta and samp installed. It is worth mentioning that I only tried this process in windows. Now what you will do is create a file with the name of `rcon.bat` and in that file will go the following: ```rcon.exe IP PORT PASS```, they will change `IP` to the IP of their server, `PORT` for the port of your server and `PASS` for the RCON password. They will then be able to run commands remotely, use "exit" to shut down the server.

It is possible that using any of these methods will cause the server to turn back on so it is better to use the command twice, I recommend using the remote console.
Apart from changing to SSH you can also keep using HTTPS, if you don't mind to put your password in clear text. Put this in your ~/.netrc and it won't ask for your username/password (at least on Linux):

machine github.com
       login <user>
       password <password>

http://stackoverflow.com/questions/6565357/git-push-requires-username-and-password

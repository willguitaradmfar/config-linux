import xmpp

username = 'willguitaradmfar'
passwd = 'aeta22042011'
to='robertapkn@gmail.com'
msg='vc e tudo pra mim'


client = xmpp.Client('gmail.com')
client.connect(server=('talk.google.com',5223))
client.auth(username, passwd, 'botty')
client.sendInitPresence()
message = xmpp.Message(to, msg)
message.setAttr('type', 'chat')
client.send(message)

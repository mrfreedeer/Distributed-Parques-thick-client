import socket

servsocket = socket.socket()

servsocket.bind(("127.0.0.1", 8000))
servsocket.listen(4)

c, addr = servsocket.accept()
print ("Connection from: ", addr)

print c.recv(1024)

servsocket.close()

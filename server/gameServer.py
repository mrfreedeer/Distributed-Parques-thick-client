import socket
import threading
import json
import time

availablecolours = ["red", "blue", "green", "yellow"]
clients = []
players = '{"transition":true, "playerspositions": {"player1": {"pawn1": 22 , "pawn2": 56, "pawn3": 65 , "pawn4": 55}}}\n'
class Receive(threading.Thread):
    def __init__(self, client,addr):
            super(Receive,self).__init__()
            self.client = client
            self.addr = addr
    def run(self):
        while True:
           incoming = self.client.recv(1024)
           data = json.loads(incoming)
           if "colour" in data:
               availablecolours.remove(data["colour"])
           else:
               position = data
               print position
               print type(position)
               position = json.loads(position)
               print position['pawn1']

servsocket = socket.socket()

servsocket.bind(("127.0.0.1", 8000))
servsocket.listen(4)

print "Parques Server Running..."
while True:
    c, addr = servsocket.accept()
    print ("Connection from: ", addr)
    c.send('{"playersQuantity": 1}\n')
    time.sleep(5)
    c.send(players)
    clients.append(c)
    t = Receive(c,addr)
    t.start()
servsocket.close()

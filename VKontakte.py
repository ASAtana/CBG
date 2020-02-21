import requests
import networkx
import time
import collections

def get_friends_ids(user_id):
    friends_url = 'https://api.vk.com/method/friends.get?user_id={}' 
    json_response = requests.get(friends_url.format(user_id)).json()
    if json_response.get('error'):
        print json_response.get('error')
        return list()
    return json_response[u'response']


graph = {}
friend_ids = get_friends_ids(451279584)
for friend_id in friend_ids:
    print 'Processing id: ', friend_id
    graph[friend_id] = get_friends_ids(friend_id)

deq = collections.deque(maxlen=4)
def trottling_request(url):
    deq.appendleft(time.time())
    if len(deq) == 4:
        time.sleep(max(1+deq[3]-deq[0], 0))
		
g = networkx.Graph(directed=False)
for i in graph:
    g.add_node(i)
    for j in graph[i]:
        if i != j and i in friend_ids and j in friend_ids:
            g.add_edge(i, j)

pos=networkx.graphviz_layout(g,prog="neato")
networkx.draw(g, pos, node_size=30, with_labels=False, width=0.2)
networkx.write_graphml(g, 'graph.graphml')
import json
# open node1.json because it has no white spaces
fin = open('nodes1.json', 'rt')
data = json.load(fin)
fin.close()
communities = {}
for d in data:
    if d['community'] not in communities:
        communities[d['community']] = 1
    else:
        communities[d['community']] += 1
# print(communities)

fout = open('labeling.cypher', 'wt')
for d in data:
    nodeId = str(d['id'])
    community = d['community']
    fout.write("MATCH ( node { code: '" + str(nodeId) + "'} ) ")
    if communities[community] >= 20:
        fout.write("SET node:c" + str(community) + "\n")
    else:
        fout.write("DETACH DELETE node\n")
    fout.write("WITH 1 as dummy\n")
fout.write("MATCH(n) RETURN(n)")
fout.close()

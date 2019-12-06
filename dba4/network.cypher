CALL apoc.load.json('file:///network.json') YIELD value AS network
MERGE(a:Disease{code: network.a.id, name: network.a.name})
MERGE(b:Disease{code: network.b.id, name: network.b.name})
MERGE (a)-[:knows]->(b);

CALL algo.louvain.stream(null, 'knows')
YIELD nodeId, community
RETURN algo.asNode(nodeId).code as id, community
ORDER BY community;

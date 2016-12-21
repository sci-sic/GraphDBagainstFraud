

# First load Neo4j DB 
library(generator)
library(RNeo4j)

#' Generate random register database
n = 1000
df <- data.frame(name = r_full_names(n),
       birth_Date = r_date_of_births(n),
       email = r_email_addresses(n),
       cc = r_credit_card_numbers(n),
       phone = r_phone_numbers(n),
       ip = r_ipv4_addresses(n)
       )

#' Connect to DB
graph = startGraph("http://localhost:7474/db/data/", username = "neo4j", password = "neo4j")
clear(graph)

#' Define constraints
addConstraint(graph, "Person", "name")
addConstraint(graph, "Birth", "date")
addConstraint(graph, "IP", "address")
addConstraint(graph, "Card", "number")
addConstraint(graph, "Phone", "number")
addConstraint(graph, "Email", "address")

#' Generate DB with no Fraud Rings

# for(i in 1:n){  
#   person = createNode(graph, "Person", name = df$name[i])
#   bd = createNode(graph, "Birth", date = df$birth_Date[i])
#   ip = createNode(graph, "IP", address = df$ip[i])
#   cc = createNode(graph, "Card", number = df$cc[i])
#   phone = createNode(graph, "Phone", number = df$phone[i])
#   email = createNode(graph, "Email", address = df$email[i])
#   
#   createRel(person, "HAS_PHONE", phone)
#   createRel(person, "WAS_BORN", bd)
#   createRel(person, "HAS_IP", ip)
#   createRel(person, "HAS_CARD", cc)
#   createRel(person, "HAS_EMAIL", email)
# } 

#' Generate DB with sucspicious users
for(i in 1:n){
  person = createNode(graph, "Person", name = df$name[i])
  bd = createNode(graph, "Birth", date = df$birth_Date[i])
  if( 4 < (i + 4) %% 150)
    ip = createNode(graph, "IP", address = df$ip[i])
  cc = createNode(graph, "Card", number = df$cc[i])
  if( 4 < (i + 3) %% 165)
    phone = createNode(graph, "Phone", number = df$phone[i])
  if( 2 < (i + 3) %% 165)
    email = createNode(graph, "Email", address = df$email[i])
  
  createRel(person, "HAS_PHONE", phone)
  createRel(person, "WAS_BORN", bd)
  createRel(person, "HAS_IP", ip)
  createRel(person, "HAS_CARD", cc)
  createRel(person, "HAS_EMAIL", email)
} 

#' Query for summarizing size and number of rings wich could lead to fraud detection
query1 = "MATCH (person:Person)-[]->(contactInformation) 
  WITH contactInformation,
  count(person) AS RingSize
  MATCH (contactInformation)<-[]-(person)
  WITH collect(person.name) AS Persons,
  contactInformation, RingSize
  WHERE RingSize > 1
  RETURN Persons AS FraudRing,
  labels(contactInformation) AS ContactType,
  RingSize
  ORDER BY RingSize DESC" 

t = Sys.time()
cypher(graph, query1)
print(Sys.time() - t)

#' Query  for  finding the largest subgraph containing a specific user
query2 = 'MATCH (root {name: "Desire Green" })-[rels*]-(b) 
UNWIND rels AS rel 
RETURN root, 
collect({start: startNode(rel), 
type:      type(rel), 
end:   endNode(rel)}) as component'

t = Sys.time()
cypher(graph, query2)
print(Sys.time() - t)



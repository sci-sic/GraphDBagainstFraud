# GraphDBagainstFraud
A brief example of how to use graph database to detect identity fraud using the 'RNeo4j' Package to connect R and Neo4j

___________________________________________________________________________________________________________________________

## Requirements
R 3.3.1

Neo4j 3.1

### Abstract
It will exemplify a case of using non-relational databases to detect identity falsification fraud, making use of the advantages (at runtime) that databases of this type have for finding relationships between data.
The type of fraud to which I will refer is one in which a person falsifies one or more identities to request credits to the institution without having to pay them, leaving the institution with difficulties to recover the debt granted.

### The art of counterfeiting

Falsification of identity can generate great losses to banking institutions. Once the fraud is done, there will be no individual to collect and the bank will waste time looking for a ghost. But it takes a little organization.

Identity theft can be a good starting point. Sometimes all that is needed is a real document like a social security number. Equipped with this, a fraudster can falsify a first identity, or else he can invent a name, age, date of birth, address, telephone number, etc. The goal is to create a (fake) identity that has all the characteristics of a real person. Scammers will ensure that their identity can bypass security controls. This is where having a "real", verifiable piece of identity (such as a person's statement of social security number) is useful.

### Implementation

First I generated a (relational) database with randomly generated records (name, phone number, credit card number, email address, iP address), and then I established the constraints and relationships to migrate this database to a non-relational schema.

### Analysis

On one hand, it is possible to obtain the maximum related subgraph (of user information) from a new user and verify the relationships that may it have with other users, on the other hand a more general analysis can be done regarding the number and size of rings that are formed by users Who share information.

**Note:** PDF file is in Spanish.

### References

[1] CRAN, 2016, ”Package ‘RNeo4j’:

https://cran.r-project.org/web/packages/RNeo4j/RNeo4j.pdf

[2] Linkurious, 2016, “How to detect bank loan fraud with graphs : part 2”: 

https://linkurio.us/how-to-detect-bank-loan-fraud-with-graphs-part-2/

[3] Nicole White, 2016, “Demo of RNeo4j part 1”:

https://nicolewhite.github.io/2014/05/30/demo-of-rneo4j-part1.html

## [Back to project README](../README.md)
## [Back to task description](./task.md#02-/-03-.-Question:-Scaling?)

> Now, let’s imagine we have 100 000 000 job offers in our database, and 1000 new job offers per second (yeah, it’s a lot coming in!). What do you implement if we want the same output than in the previous exercise in real-time?

The answer for that question relies on DB solution we already chose for our project.

# SQL DBs

SQL databases can be used for transactions and relational data model which gives us ACID and data consistency. If our project already uses such database, we can **scale vertically** as much as we can to provide better performance. However in case like this it is a good idea to use caching layer in front of database, that way we can decrease request to the database, but that helps for queries requesting data, not one that inserts data.

[To scale for inserts in SQL DB](https://stackoverflow.com/questions/7090243/sql-speed-up-performance-of-insert) we can **remove all triggers and constraints** on the table to which inserts are coming. We can also **remove all indexes which isn't needed for the insert operation**.

In the given link above there is a bunch of other performance optimization I'm not familiar with, but I believe that it would be interesting challenge to solve this issue if I ever run into such.

# NoSQL DBs

Unlike SQL DBs, NoSQL DBs gives us ability to scale horizontally. That allows us to handle workload by increasing the amount of machines in cluster instead of relying on capacity of single server machine. However this comes with a price - our data cannot be strongly consistent anymore, since cluster nodes handle data transformation in parallel. NoSQL provides eventual data consistency instead of strong data consistency.

***In the given task to view total amount of jobs it's not required for data to be strongly consistent, amount of jobs is not a critical data (banking transactions on the other hand are), so NoSQL solution can be an appropriate one to handle the workload in question.***

# New SQL DBs

In case when the project relies on SQL (especially PostgreSQL) database and team wants to have horizontal scaling, it can be done with the help of [CockroachDB](https://www.cockroachlabs.com/).

CockroachDB is a modern database which works with SQL syntax and provides horizontal scalability at the same time.

[However CAP theorem](https://en.wikipedia.org/wiki/CAP_theorem) says that it is impossible for a distributed DB to simultaneously provide more than 2 of the following three guarantees:
* Consistency
* Availability
* Partition tolerance

Because of this in case when team are interested in such solutions as CockroachDB, we should look into those solutions carefully to understand where their weak sides are, and when we find those weak sides we should compare them with the task at hand, will it serve our case or not.
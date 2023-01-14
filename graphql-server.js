import { createSchema, createYoga } from "graphql-yoga";
import { createServer } from "node:http";

const buses = [
	{
		id: 1,
		name: "Green bus",
		rows: 6,
		seats: { front: 1, leftRow: 2, rightRow: 2, back: 4 },
	},
	{
		id: 2,
		name: "Yellow bus",
		rows: 8,
		seats: { front: 1, leftRow: 10, rightRow: 12, back: 5 },
	},
	{
		id: 3,
		name: "Blue bus",
		rows: 10,
		seats: { front: 2, leftRow: 3, rightRow: 4, back: 5 },
	},
];

const yoga = createYoga({
	schema: createSchema({
		typeDefs: /* GraphQL */ `
        type Query {
            buses: [Bus!]!
        }

        type Bus {
            id: Int!
            name: String!
            rows: Int!
            seats: Seats!
        }

        type Seats {
            front: Int!
            leftRow: Int!
            rightRow: Int!
            back: Int!
        }
        `,
		resolvers: {
			Query: {
				buses: () => buses,
			},
			Bus: {
				id: (parent) => parent.id,
				name: (parent) => parent.name,
				rows: (parent) => parent.rows,
				seats: (parent) => parent.seats,
			},
			Seats: {
				front: (parent) => parent.front,
				leftRow: (parent) => parent.leftRow,
				rightRow: (parent) => parent.rightRow,
				back: (parent) => parent.back,
			},
		},
	}),
});

const server = createServer(yoga);
server.listen(4000, () => {
	console.info("Server is running on http://localhost:4000/graphql");
});

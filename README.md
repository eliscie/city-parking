# City Parking 🚌️ 🚌️
Repository showing a possibly troublesome [`elm-gql`](https://github.com/vendrinc/elm-gql) fragment issue.

## Running
### Requirements
- Elm
- Node.js

### Details
- Please clone the GitHub repository and enter the newly created directory
    ```sh
    git clone https://github.com/eliscie/city-parking
    ```
- Run `npm install`
- Start two terminal windows and
    - run `npm run graphql-server` in one of them. The GraphQL server should run at `localhost:4000`
    - run `npm run build` in the other one
- Open the [`index.html`](./index.html) file in your browser
- And finally, please take a look at the left and right seat row in Blue and Yellow buses :(

Test query #2 should match the control query.

If you wish to check result of the [query](./src/CityParking.gql) in the GraphiQL tool, you can open the [`graphiql.html`](./graphiql.html) file in your browser.
